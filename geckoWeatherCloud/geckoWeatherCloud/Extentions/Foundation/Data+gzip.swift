//
//  Data+gzip.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//
import Foundation
import zlib

/**解压缩流大小**/
private let GZIP_STREAM_SIZE: Int32 = Int32(MemoryLayout<z_stream>.size)
/**解压缩缓冲区大小**/
private let GZIP_BUF_LENGTH:Int = 512
/**默认空数据**/
private let GZIP_NULL_DATA = Data()

// MARK: - Properties
public extension Data {
    
    /// 判断是否zip压缩后的数据。
    var isGZipCompressed :Bool {
        return self.starts(with: [0x1f,0x8b])
    }
    
    
    /// gzip压缩。
    ///
    /// - Returns: 压缩后的数据
    func gzipCompress() -> Data {
        
        guard self.count > 0 else {
            return self
        }
        
        var stream = z_stream()
        stream.avail_in = uInt(self.count)
        stream.total_out = 0
        
        self.withUnsafeBytes { (bytes:UnsafePointer<Bytef>) in

            stream.next_in = UnsafeMutablePointer<Bytef>(mutating:bytes)
        }
        
        var status = deflateInit2_(&stream,Z_DEFAULT_COMPRESSION, Z_DEFLATED, MAX_WBITS + 16, MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY, ZLIB_VERSION, GZIP_STREAM_SIZE)
        
        if  status != Z_OK {
            return  GZIP_NULL_DATA
        }
        
        var compressedData = Data()
        
        while stream.avail_out == 0 {
            
            if Int(stream.total_out) >= compressedData.count {
                compressedData.count += GZIP_BUF_LENGTH
            }
            
            stream.avail_out = uInt(GZIP_BUF_LENGTH)
            
            compressedData.withUnsafeMutableBytes { (bytes:UnsafeMutablePointer<Bytef>) -> Void in
                stream.next_out = bytes.advanced(by: Int(stream.total_out))
            }
            
            status = deflate(&stream, Z_FINISH)
            
            if status != Z_OK && status != Z_STREAM_END {
                return GZIP_NULL_DATA
            }
        }
        
        guard deflateEnd(&stream) == Z_OK else {
            return GZIP_NULL_DATA
        }
        
        compressedData.count = Int(stream.total_out)
        return compressedData
    }
    
    
    /// gzip解压。
    ///
    /// - Returns: 解压缩后的数据
    func gzipUncompress() ->Data {
        guard self.count > 0  else {
            return GZIP_NULL_DATA
        }
        
        guard self.isGZipCompressed else {
            return self
        }
        
        var  stream = z_stream()
        
        self.withUnsafeBytes { (bytes:UnsafePointer<Bytef>) in
            stream.next_in =  UnsafeMutablePointer<Bytef>(mutating: bytes)
        }
        
        stream.avail_in = uInt(self.count)
        stream.total_out = 0
        
        
        var status: Int32 = inflateInit2_(&stream, MAX_WBITS + 16, ZLIB_VERSION,GZIP_STREAM_SIZE)
        
        guard status == Z_OK else {
            return GZIP_NULL_DATA
        }
        
        var decompressed = Data(capacity: self.count * 2)
        while stream.avail_out == 0 {
            
            stream.avail_out = uInt(GZIP_BUF_LENGTH)
            decompressed.count += GZIP_BUF_LENGTH
            
            decompressed.withUnsafeMutableBytes { (bytes:UnsafeMutablePointer<Bytef>)in
                stream.next_out = bytes.advanced(by: Int(stream.total_out))
            }
            
            status = inflate(&stream, Z_SYNC_FLUSH)
            
            if status != Z_OK && status != Z_STREAM_END {
                break
            }
        }
        
        if inflateEnd(&stream) != Z_OK {
            return GZIP_NULL_DATA
        }
        
        decompressed.count = Int(stream.total_out)
        return decompressed
    }
    
    
    /**  test
     
     let string = "Hello world!"
     let helloData =  string.data(using: .utf8)
     let compressData =   helloData?.gzipCompress()
     let uncompressData =  compressData?.gzipUncompress()
     let resString =  String(data: uncompressData!, encoding: String.Encoding.utf8)
     print(resString)
     
     */
    
}


