//
//  BooksReaderView.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 29/06/23.
//

import UIKit
import PDFKit
import WebKit
import SafariServices

class BooksReaderView: UIViewController {
    
    
    var bookFileName = ""
    var isRootFrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if isRootFrom == BookVary.books {
           // self.displayPdf(fileName: bookFileName)
            self.openWeb(contentLink: bookFileName)
        } else {
           // self.displayWebView(fileName: bookFileName)
            self.openWeb(contentLink: bookFileName)
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   private func createPdfView(withFrame frame: CGRect) -> PDFView {
       let pdfView = PDFView(frame: frame)
       pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       pdfView.autoScales = true
       
       return pdfView
   }
   
   private func createPdfDocument(forFileName fileName: String) -> PDFDocument? {
       if let resourceUrl = URL(string: fileName) {
           return PDFDocument(url: resourceUrl)
       }

       return nil
   }
   
    private func displayPdf(fileName: String) {
       let pdfView = self.createPdfView(withFrame: self.view.bounds)
       
       if let pdfDocument = self.createPdfDocument(forFileName: fileName) {
           self.view.addSubview(pdfView)
           pdfView.document = pdfDocument
       }
   }
    private func displayWebView(fileName: String) {
        if let webView = self.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
        }
    }
    private func createWebView(withFrame frame: CGRect) -> WKWebView? {
        let webView = WKWebView(frame: frame)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let resourceUrl = URL(string: bookFileName) {
            let request = URLRequest(url: resourceUrl)
            webView.load(request)

            return webView
        }
        
        return nil
    }
    func openWeb(contentLink: String) {
        let url = URL(string: contentLink)!
        let controller = SFSafariViewController(url: url)
        controller.preferredBarTintColor = UIColor.darkGray
        controller.preferredControlTintColor = UIColor.groupTableViewBackground
        controller.dismissButtonStyle = .close
        controller.configuration.barCollapsingEnabled = true
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }

}
extension BooksReaderView: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
