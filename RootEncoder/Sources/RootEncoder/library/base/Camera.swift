//
//  Camera.swift
//  RootEncoder
//
//  Created by Berlin Shih(施伯林) on 2025/11/14.
//

public class Camera: CameraBase {
    public protocol Listener {
        func startStreamImp(endpoint: String)
        func stopStreamImp()
        func setAudioCodecImp(codec: AudioCodec)
        func setVideoCodecImp(codec: VideoCodec)
        func onAudioInfoImp(sampleRate: Int, isStereo: Bool)
        func onVideoInfoImp(sps: [UInt8], pps: [UInt8], vps: [UInt8]?)
        func getAudioDataImp(buffer: [UInt8], ts: UInt64)
        func getVideoDataImp(buffer: [UInt8], ts: UInt64)
    }

    private var listener: Listener? = nil

    public func registerListener(_ listener: Listener) {
        self.listener = listener
    }

    override func startStreamImp(endpoint: String) {
        listener?.startStreamImp(endpoint: endpoint)
    }

    override func stopStreamImp() {
        listener?.stopStreamImp()
    }

    override func setAudioCodecImp(codec: AudioCodec) {
        listener?.setAudioCodecImp(codec: codec)
    }

    override func setVideoCodecImp(codec: VideoCodec) {
        listener?.setVideoCodecImp(codec: codec)
    }

    override func onAudioInfoImp(sampleRate: Int, isStereo: Bool) {
        listener?.onAudioInfoImp(sampleRate: sampleRate, isStereo: isStereo)
    }

    override func onVideoInfoImp(sps: [UInt8], pps: [UInt8], vps: [UInt8]?) {
        listener?.onVideoInfoImp(sps: sps, pps: pps, vps: vps)
    }

    override func getAudioDataImp(frame: Frame) {
        listener?.getAudioDataImp(buffer: frame.buffer, ts: frame.timeStamp)
    }

    override func getVideoDataImp(frame: Frame) {
        listener?.getVideoDataImp(buffer: frame.buffer, ts: frame.timeStamp)
    }
}
