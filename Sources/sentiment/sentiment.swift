import Foundation
#if canImport(NaturalLanguage)
import NaturalLanguage
#endif

func sentiment(of string: String) -> String? {
    guard #available(OSX 10.15, *) else { fatalError() }

    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    tagger.string = string

    let tags = tagger.tags(in: string.startIndex..<string.endIndex, unit: .paragraph, scheme: .sentimentScore).compactMap { (tag, _) in tag }
    guard tags.count > 0 else { return nil }

    let formatter = NumberFormatter()
    formatter.localizesFormat = false
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 1
    formatter.maximumFractionDigits = 6

    let averageSentimentScore = tags.compactMap { tag in formatter.number(from: tag.rawValue)?.doubleValue }.reduce(0, +) / Double(tags.count)
    return formatter.string(for: averageSentimentScore)
}
