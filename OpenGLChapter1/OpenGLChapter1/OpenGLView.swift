//
//  OpenGLView.swift
//  OpenGLChapter1
//
//  Created by ShawnDu on 15/12/11.
//  Copyright © 2015年 Shawn. All rights reserved.
//

import UIKit

class OpenGLView: UIView {

    var eaglLayer: CAEAGLLayer!
    var context: EAGLContext?
    var colorRenderBuffer: GLuint = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func layerClass() -> AnyObject {
        return CAEAGLLayer.self
    }
    
    private func config() {
        self.setupLayer()
        self.setupContext()
        self.setupRenderBuffer()
        self.setupFrameBuffer()
        self.render()
    }
    
    private func setupLayer() {
        eaglLayer = CAEAGLLayer(layer: self.layer)
        eaglLayer.opaque = true
        self.layer.addSublayer(eaglLayer)
    }
    
    private func setupContext() {
        let api = EAGLRenderingAPI.OpenGLES3
        if let context = EAGLContext.init(API: api) {
            self.context = context
            if !EAGLContext.setCurrentContext(context) {
                print("Failed to set current opengl context")
                exit(1)
            }
        } else {
            print("failed to initial opengl3.0 context")
            exit(1)
        }
    }
    
    private func setupRenderBuffer() {
        glGenRenderbuffers(1, &colorRenderBuffer)
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), colorRenderBuffer)
        context?.renderbufferStorage(Int(GL_RENDERBUFFER), fromDrawable: eaglLayer)
    }
    
    private func setupFrameBuffer() {
        var frameBuffer: GLuint = 0
        glGenFramebuffers(1, &frameBuffer)
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), frameBuffer)
        glFramebufferRenderbuffer(GLenum(GL_FRAMEBUFFER), GLenum(GL_COLOR_ATTACHMENT0), GLenum(GL_RENDERBUFFER), colorRenderBuffer)
    }
    
    private func render() {
        glClearColor(0.6, 0.6, 0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        let success = context?.presentRenderbuffer(Int(GL_RENDERBUFFER))
        print(success)
    }
}
