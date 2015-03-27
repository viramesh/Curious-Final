//
//        __                             _____         _ ______
//       / /   ____  ________  ____ ___ / ___/      __(_) __/ /___  ______ ___
//      / /   / __ \/ ___/ _ \/ __ `__ \\__ \ | /| / / / /_/ __/ / / / __ `__ \
//     / /___/ /_/ / /  /  __/ / / / / /__/ / |/ |/ / / __/ /_/ /_/ / / / / / /
//    /_____/\____/_/   \___/_/ /_/ /_/____/|__/|__/_/_/  \__/\__,_/_/ /_/ /_/
//
//                              LoremSwiftum.swift
//                 http://github.com/lukaskubanek/LoremSwiftum
//               2014 (c) Lukas Kubanek (http://lukaskubanek.com)
//

import Foundation
import UIKit

// MARK: - Utilities

private func randomNumber(max: Int) -> Int {
    return randomNumber(min: 0, max: max)
}

private func randomNumber(max: UInt) -> UInt {
    return randomNumber(min: 0, max: max)
}

private func randomNumber(#min: Int, #max: Int) -> Int {
    return min + Int(arc4random_uniform(UInt32(max - min)))
}

private func randomNumber(#min: UInt, #max: UInt) -> UInt {
    return UInt(randomNumber(min: Int(min), max: Int(max)))
}

extension Array {
    private func randomElement() -> T {
        return self[randomNumber(self.count)]
    }
}

extension String {
    private func stringByCapitalizingFirstLetter() -> String {
        let startIndex = self.startIndex
        let endIndex = self.startIndex.successor()
        let capitalizedFirstLetter = self.substringToIndex(advance(startIndex, 1)).capitalizedString
        return self.stringByReplacingCharactersInRange(startIndex..<endIndex, withString: capitalizedFirstLetter)
    }
}

// MARK: - Data

private let allWords = "aside bawdy more a armadillo far piteously excellent hello a woolly overlaid game the crud alas hooted hey the falcon across less therefore but jeez far mongoose pithy whale and apart owing far far more ouch much gosh much much horse shook nightingale oh forward mastodon orca under shuffled incorrectly woodpecker as lost glad goodness gosh uneasy far fox dashing over including and from the this thoughtful conclusively sarcastic circa on clung irrespective much shrugged criminally far much boa next unsaddled but far the far earthworm around the jeez the talkatively robin versus the bewitchingly next splashed more infectiously much far blushed spelled patted recast wow when far well and yikes far jeepers alongside on far weasel despicably luxuriantly quick firefly toward less the flinched human falcon within wherever rhinoceros much oh ouch far submissively when blankly blindly considering occasionally when this and redoubtable despite bluntly set hello militant darn terrier less since rampantly a one walrus doubtful coughed much a this as infallible and stylistic human or the in lucid up rebuilt imitatively and where and up diplomatically a ambitiously some a at absurdly lusciously less selfless then underwrote goodness under porpoise flexed dachshund up walking however across buffalo up that wherever earthworm unlike much far gosh goodhearted much as rooster bowed far about along yet cringed wow outside inset then insect this groggily cagy regardless boa much and when far but some much underneath held halfhearted much avowedly that fetching peered impotently far placidly goodness vividly the some and on crud inside bald properly hence howled and newt save hen a oh with gosh jaunty because well regarding dogged that vengefully up and unsaddled abortively advantageously far told in wow terrier depending".componentsSeparatedByString(" ")

private let firstNames = "Judith Angelo Margarita Kerry Elaine Lorenzo Justice Doris Raul Liliana Kerry Elise Ciaran Johnny Moses Davion Penny Mohammed Harvey Sheryl Hudson Brendan Brooklynn Denis Sadie Trisha Jacquelyn Virgil Cindy Alexa Marianne Giselle Casey Alondra Angela Katherine Skyler Kyleigh Carly Abel Adrianna Luis Dominick Eoin Noel Ciara Roberto Skylar Brock Earl Dwayne Jackie Hamish Sienna Nolan Daren Jean Shirley Connor Geraldine Niall Kristi Monty Yvonne Tammie Zachariah Fatima Ruby Nadia Anahi Calum Peggy Alfredo Marybeth Bonnie Gordon Cara John Staci Samuel Carmen Rylee Yehudi Colm Beth Dulce Darius inley Javon Jason Perla Wayne Laila Kaleigh Maggie Don Quinn Collin Aniya Zoe Isabel Clint Leland Esmeralda Emma Madeline Byron Courtney Vanessa Terry Antoinette George Constance Preston Rolando Caleb Kenneth Lynette Carley Francesca Johnnie Jordyn Arturo Camila Skye Guy Ana Kaylin Nia Colton Bart Brendon Alvin Daryl Dirk Mya Pete Joann Uriel Alonzo Agnes Chris Alyson Paola Dora Elias Allen Jackie Eric Bonita Kelvin Emiliano Ashton Kyra Kailey Sonja Alberto Ty Summer Brayden Lori Kelly Tomas Joey Billie Katie Stephanie Danielle Alexis Jamal Kieran Lucinda Eliza Allyson Melinda Alma Piper Deana Harriet Bryce Eli Jadyn Rogelio Orlaith Janet Randal Toby Carla Lorie Caitlyn Annika Isabelle inn Ewan Maisie Michelle Grady Ida Reid Emely Tricia Beau Reese Vance Dalton Lexi Rafael Makenzie Mitzi Clinton Xena Angelina Kendrick Leslie Teddy Jerald Noelle Neil Marsha Gayle Omar Abigail Alexandra Phil Andre Billy Brenden Bianca Jared Gretchen Patrick Antonio Josephine Kyla Manuel Freya Kellie Tonia Jamie Sydney Andres Ruben Harrison Hector Clyde Wendell Kaden Ian Tracy Cathleen Shawn".componentsSeparatedByString(" ")

private let lastNames = "Chung Chen Melton Hill Puckett Song Hamilton Bender Wagner McLaughlin McNamara Raynor Moon Woodard Desai Wallace Lawrence Griffin Dougherty Powers May Steele Teague Vick Gallagher Solomon Walsh Monroe Connolly Hawkins Middleton Goldstein Watts Johnston Weeks Wilkerson Barton Walton Hall Ross Chung Bender Woods Mangum Joseph Rosenthal Bowden Barton Underwood Jones Baker Merritt Cross Cooper Holmes Sharpe Morgan Hoyle Allen Rich Rich Grant Proctor Diaz Graham Watkins Hinton Marsh Hewitt Branch Walton O'Brien Case Watts Christensen Parks Hardin Lucas Eason Davidson Whitehead Rose Sparks Moore Pearson Rodgers Graves Scarborough Sutton Sinclair Bowman Olsen Love McLean Christian Lamb James Chandler Stout Cowan Golden Bowling Beasley Clapp Abrams Tilley Morse Boykin Sumner Cassidy Davidson Heath Blanchard McAllister McKenzie Byrne Schroeder Griffin Gross Perkins Robertson Palmer Brady Rowe Zhang Hodge Li Bowling Justice Glass Willis Hester Floyd Graves Fischer Norman Chan Hunt Byrd Lane Kaplan Heller May Jennings Hanna Locklear Holloway Jones Glover Vick O'Donnell Goldman McKenna Starr Stone McClure Watson Monroe Abbott Singer Hall Farrell Lucas Norman Atkins Monroe Robertson Sykes Reid Chandler Finch Hobbs Adkins Kinney Whitaker Alexander Conner Waters Becker Rollins Love Adkins Black Fox Hatcher Wu Lloyd Joyce Welch Matthews Chappell MacDonald Kane Butler Pickett Bowman Barton Kennedy Branch Thornton McNeill Weinstein Middleton Moss Lucas Rich Carlton Brady Schultz Nichols Harvey Stevenson Houston Dunn West O'Brien Barr Snyder Cain Heath Boswell Olsen Pittman Weiner Petersen Davis Coleman Terrell Norman Burch Weiner Parrott Henry Gray Chang McLean Eason Weeks Siegel Puckett Heath Hoyle Garrett Neal Baker Goldman Shaffer Choi Carver".componentsSeparatedByString(" ")

private let emailDomains = "gmail.com yahoo.com hotmail.com email.com live.com me.com mac.com aol.com fastmail.com mail.com".componentsSeparatedByString(" ")

private let emailDelimiters = ["", ".", "-", "_"]

private let domains = "twitter.com google.com youtube.com wordpress.org adobe.com blogspot.com godaddy.com wikipedia.org wordpress.com yahoo.com linkedin.com amazon.com flickr.com w3.org apple.com myspace.com tumblr.com digg.com microsoft.com vimeo.com pinterest.com qq.com stumbleupon.com youtu.be addthis.com miibeian.gov.cn delicious.com baidu.com feedburner.com bit.ly".componentsSeparatedByString(" ")

// Source: http://www.kevadamson.com/talking-of-design/article/140-alternative-characters-to-lorem-ipsum
private let tweets = ["Far away, in a forest next to a river beneath the mountains, there lived a small purple otter called Philip. Philip likes sausages. The End.", "He liked the quality sausages from Marks & Spencer but due to the recession he had been forced to shop in a less desirable supermarket. End.", "He awoke one day to find his pile of sausages missing. Roger the greedy boar with human eyes, had skateboarded into the forest & eaten them!"]

// MARK: - Public API

public class Lorem {}

// MARK: - Texts

extension Lorem {
    public class func word() -> String {
        return allWords.randomElement()
    }
    
    public class func words(count: UInt) -> String {
        return compose(word, count, middleSeparator: " ")
    }
    
    public class func sentence() -> String {
        let numberOfWordsInSentence: UInt = randomNumber(min: 10, max: 16)
        let capitalizeFirstLetter: Decorator = { $0.stringByCapitalizingFirstLetter() }
        return compose(word, numberOfWordsInSentence, middleSeparator: " ", endSeparator: ".", decorator: capitalizeFirstLetter)
    }
    
    public class func sentences(count: UInt) -> String {
        return compose(sentence, count, middleSeparator: " ")
    }
    
    public class func paragraph() -> String {
        let numberOfSentencesInParagraph: UInt = randomNumber(min: 3, max: 9)
        return sentences(numberOfSentencesInParagraph)
    }
    
    public class func paragraphs(count: UInt) -> String {
        return compose(paragraph, count, middleSeparator: "\n")
    }
    
    public class func title() -> String {
        let numberOfWordsInTitle: UInt = randomNumber(min: 2, max: 7)
        return words(numberOfWordsInTitle).capitalizedString
    }
}

// MARK: - Misc Data

extension Lorem {
    public class func name() -> String {
        return firstName() + " " + lastName()
    }
    
    public class func firstName() -> String {
        return firstNames.randomElement()
    }
    
    public class func lastName() -> String {
        return lastNames.randomElement()
    }
    
    public class func email() -> String {
        let delimiter = emailDelimiters.randomElement()
        let domain = emailDomains.randomElement()
        return (firstName() + delimiter + lastName() + "@" + domain).lowercaseString
    }
    
    public class func URL() -> NSURL {
        return NSURL(string: "http://" + domains.randomElement() + "/")!
    }
    
    public class func tweet() -> String {
        return tweets.randomElement()
    }
    
    public class func date() -> NSDate {
        let currentDate = NSDate()
        let currentCalendar = NSCalendar.currentCalendar()
        let referenceDateComponents = NSDateComponents()
        referenceDateComponents.year = -4
        let referenceDate = currentCalendar.dateByAddingComponents(referenceDateComponents, toDate: currentDate, options: nil)!
        let timeIntervalSinceReferenceDate = currentDate.timeIntervalSinceDate(referenceDate)
        let randomTimeInterval = NSTimeInterval(randomNumber(min: 0, max: Int(timeIntervalSinceReferenceDate)))
        return referenceDate.dateByAddingTimeInterval(randomTimeInterval)
    }
    
}

// MARK: - Images

extension Lorem {
    public enum ImageService {
        case LoremPixel
        case Hhhhold
        case DummyImage
        case PlaceKitten
        case Default
        
        private func toURL(width: Int, _ height: Int) -> NSURL {
            switch self {
            case .LoremPixel, .Default:
                return NSURL(string: "http://lorempixel.com/\(width)/\(height)/")!
            case .Hhhhold:
                return NSURL(string: "http://hhhhold.com/\(width)x\(height)/")!
            case .DummyImage:
                return NSURL(string: "http://dummyimage.com/\(width)x\(height)/")!
            case .PlaceKitten:
                return NSURL(string: "http://placekitten.com/\(width)/\(height)")!
            }
        }
    }
    
    public class func imageURL(#width: Int, height: Int, _ service: ImageService = .Default) -> NSURL {
        return service.toURL(width, height)
    }
    
    public class func imageURL(size: CGSize, _ service: ImageService = .Default) -> NSURL {
        return imageURL(width: Int(size.width), height: Int(size.height), service)
    }
    
    public class func image(#width: Int, height: Int, _ service: ImageService = .Default) -> UIImage {
        return UIImage(data: NSData(contentsOfURL: imageURL(width: width, height: height, service))!)!
    }
    
    public class func image(size: CGSize, _ service: ImageService = .Default) -> UIImage {
        return image(width: Int(size.width), height: Int(size.height), service)
    }
    
    public class func image(#width: Int, height: Int, completionHandler: (UIImage -> Void)) {
        image(width: width, height: height, .Default, completionHandler: completionHandler)
    }
    
    public class func image(#width: Int, height: Int,  _ service: ImageService, completionHandler: (UIImage -> Void)) {
        let request = NSURLRequest(URL: imageURL(width: width, height: height, service))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            completionHandler(UIImage(data: data)!)
        }
    }
    
    public class func image(size: CGSize, completionHandler: (UIImage -> Void)) {
        image(size, .Default, completionHandler: completionHandler)
    }
    
    public class func image(size: CGSize, _ service: ImageService, completionHandler: (UIImage -> Void)) {
        image(width: Int(size.width), height: Int(size.height), service, completionHandler: completionHandler)
    }
}

// MARK: - Private API

extension Lorem {
    private typealias Generator = (Void -> String)
    private typealias Decorator = (String -> String)
    
    private class func compose(generator: Generator, _ count: UInt, middleSeparator: String, endSeparator: String = "", decorator: Decorator = { $0 }) -> String {
        var result = ""
        for index in 0..<count {
            result += generator()
            
            if (index < count - 1) {
                result += middleSeparator
            } else {
                result += endSeparator
            }
        }
        return decorator(result)
    }
}