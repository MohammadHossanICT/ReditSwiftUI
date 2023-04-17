//
//  RedithCellView.swift
//  ReditSwiftUIDemo
//
//  Created by M A Hossan on 17/04/2023.
//

import SwiftUI

struct RedithCellView: View {
    let story: Story
    var body: some View {
        HStack {
            if let url = URL(string: story.thumbnail ?? "Image not Found"){
                RedithAsyncImageView(url: url)
                    .frame(width: 150, height: 150)
                    .mask(RoundedRectangle(cornerRadius: 16))
            }
            VStack(alignment: .leading,spacing: 5){
                Text("Title: " + story.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)

                Text("Total Comments: \(story.numComments)")
                    .frame(maxWidth: .infinity, alignment: .leading)


                Text("Score: \(story.score)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)

            }
        }
    }
}
struct RedithCellView_Previews: PreviewProvider {
    static var previews: some View {
        RedithCellView(story: Constants.previewRedithObj)
    }
}


