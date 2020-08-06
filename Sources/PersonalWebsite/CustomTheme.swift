import Plot
import Publish

extension Theme where Site == PersonalWebsite {
    static var custom: Self {
        Theme(
            htmlFactory: CustomHTMLFactory(),
            resourcePaths: [
                "Resources/CustomTheme/styles.css"
            ]
        )
    }
    
    private struct CustomHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Index, context: PublishingContext<PersonalWebsite>) throws -> HTML {
            HTML(
                .head(for: index, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .p(
                        .class("description"),
                        .text(context.site.description),
                        .a(
                            .text("Simplified Automation"),
                            .href("https://simplifiedautomation.ca"),
                            .target(.blank)
                        )
                    ),
                    .img(
                        .src(context.site.imagePath!),
                        .class("image-cropper")
                    ),
                    .wrapper(
                        .a(
                            .img(
                                .src(context.site.twitter),
                                .class("social")
                            ),
                            .href("https://twitter.com/IshmeetSing"),
                            .target(.blank)
                        ),
                        .a(
                            .img(
                                .src(context.site.linkedin),
                                .class("social")
                            ),
                            .href("https://www.linkedin.com/in/ishmeetsinghsethi"),
                            .target(.blank)
                        ),
                        .a(
                            .img(
                                .src(context.site.github),
                                .class("social")
                            ),
                            .href("https://github.com/sethi-ishmeet"),
                            .target(.blank)
                        )
                    ),
                    .span(),
                    .footer(for: context.site)
                )
            )
        }
        
        func makeSectionHTML(for section: Section<PersonalWebsite>, context: PublishingContext<PersonalWebsite>) throws -> HTML {
            HTML()
        }
        
        func makeItemHTML(for item: Item<PersonalWebsite>, context: PublishingContext<PersonalWebsite>) throws -> HTML {
            HTML()
        }
        
        func makePageHTML(for page: Page, context: PublishingContext<PersonalWebsite>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(.contentBody(page.body)),
                    .footer(for: context.site)
                )
            )
        }
        
        func makeTagListHTML(for page: TagListPage, context: PublishingContext<PersonalWebsite>) throws -> HTML? {
            return nil
        }
        
        func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<PersonalWebsite>) throws -> HTML? {
            return nil
        }
        
        
        
    }
}


private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        return .header(
            .wrapper(
                .a(.class("site-name"), .href("/"), .text(context.site.name))
            )
        )
    }
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                        )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                    ))
            }
        )
    }
    
    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
                ))
            })
    }
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Built in Swift using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                ),
                .text(".")
            )
        )
    }
}
