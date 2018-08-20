//
//  XCGLog.swift
//  laoshizaishang
//
//  Created by zhaoyunyi on 2017/9/25.
//  Copyright © 2017年 fragment. All rights reserved.
//

import Foundation
import XCGLogger

let log: XCGLogger = {
    // Setup XCGLogger
    let log = XCGLogger.default

    //日志文件地址
    let cachePath = FileManager.default.urls(for: .cachesDirectory,
                                             in: .userDomainMask)[0]
    let loggerCachePath = cachePath.appendingPathComponent("log.txt")
    
    #if USE_NSLOG // Set via Build Settings, under Other Swift Flags
        log.remove(destinationWithIdentifier: XCGLogger.Constants.baseConsoleDestinationIdentifier)
        log.add(destination: AppleSystemLogDestination(identifier: XCGLogger.Constants.systemLogDestinationIdentifier))
        log.logAppDetails()
    #else
    
        log.setup(level: logLevel, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: loggerCachePath)
    
        // Add colour (using the ANSI format) to our file log, you can see the colour when `cat`ing or `tail`ing the file in Terminal on macOS
        // This is mostly useful when testing in the simulator, or if you have the app sending you log files remotely
        if let fileDestination: FileDestination = log.destination(withIdentifier: XCGLogger.Constants.fileDestinationIdentifier) as? FileDestination {
            let ansiColorLogFormatter: ANSIColorLogFormatter = ANSIColorLogFormatter()
            ansiColorLogFormatter.colorize(level: .verbose, with: .colorIndex(number: 244), options: [.faint])
            ansiColorLogFormatter.colorize(level: .debug, with: .black)
            ansiColorLogFormatter.colorize(level: .info, with: .blue, options: [.underline])
            ansiColorLogFormatter.colorize(level: .warning, with: .red, options: [.faint])
            ansiColorLogFormatter.colorize(level: .error, with: .red, options: [.bold])
            ansiColorLogFormatter.colorize(level: .severe, with: .white, on: .red)
            fileDestination.formatters = [ansiColorLogFormatter]
            
            //文件输出在后台处理
            fileDestination.logQueue = XCGLogger.logQueue
            
            //logger对象中添加控制台输出
            log.add(destination: fileDestination)
            
            //开始启用
            log.logAppDetails()
        }
        
    #endif
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: " 🗯🗯🗯", to: .verbose)
    emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: " 🔹🔹🔹", to: .debug)
    emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: " ℹ️ℹ️ℹ️", to: .info)
    emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: " ⚠️⚠️⚠️", to: .warning)
    emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", postfix: " ‼️‼️‼️", to: .error)
    emojiLogFormatter.apply(prefix: "💣💣💣 ", postfix: " 💣💣💣", to: .severe)
    
    // 颜色
    let xcodeColorsLogFormatter: XcodeColorsLogFormatter = XcodeColorsLogFormatter()
    xcodeColorsLogFormatter.colorize(level: .verbose, with: .lightGrey)
    xcodeColorsLogFormatter.colorize(level: .debug, with: .darkGrey)
    xcodeColorsLogFormatter.colorize(level: .info, with: .blue)
    xcodeColorsLogFormatter.colorize(level: .warning, with: .orange)
    xcodeColorsLogFormatter.colorize(level: .error, with: .red)
    xcodeColorsLogFormatter.colorize(level: .severe, with: .white, on: .red)
    
    log.formatters = [emojiLogFormatter, xcodeColorsLogFormatter]
    
    return log
}()


