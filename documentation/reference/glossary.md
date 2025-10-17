# Glossary

## Technical Terms

### MkDocs

**MkDocs** is a static site generator that's geared towards project documentation. It uses Markdown files to create documentation websites.

- **Configuration**: Defined in `mkdocs.yml`
- **Themes**: Customizable appearance and layout
- **Plugins**: Extend functionality
- **Build Process**: Converts Markdown to HTML

### Material Theme

**Material Theme** is a popular MkDocs theme that provides a modern, responsive design with advanced features.

- **Features**: Navigation, search, code highlighting, etc.
- **Customization**: CSS, JavaScript, and template overrides
- **Responsive**: Works on all device sizes
- **Accessibility**: Built-in accessibility features

### Git Submodules

**Git Submodules** allow you to include external Git repositories as subdirectories within your main repository.

- **External Content**: Include content from other repositories
- **Version Control**: Track specific commits of external content
- **Independence**: External repositories remain independent
- **Updates**: Can be updated independently

### Monorepo

**Monorepo** (monolithic repository) is a software development strategy where code for multiple projects is stored in the same repository.

- **Unified Build**: Single build process for multiple projects
- **Shared Dependencies**: Common dependencies and configuration
- **Cross-Project Changes**: Easier to make changes across projects
- **Simplified CI/CD**: Single pipeline for all projects

### SWHID

**SWHID** (Software Heritage Identifier) is a unique identifier for software artifacts in the Software Heritage archive.

- **Format**: `swh:1:cnt:hash`
- **Components**: Type, version, and hash
- **Uniqueness**: Globally unique identifiers
- **Persistence**: Permanent identifiers for software

## Website Components

### Navigation

**Navigation** refers to the system of links and menus that help users move around the website.

- **Horizontal Navigation**: Top-level navigation bar
- **Sidebar Navigation**: Left-side navigation menu
- **Breadcrumb Navigation**: Shows current page location
- **Footer Navigation**: Additional links at the bottom

### Content Management

**Content Management** refers to the process of creating, editing, and organizing website content.

- **Markdown**: Text formatting language
- **Front Matter**: Metadata at the top of files
- **Templates**: Reusable page layouts
- **Assets**: Images, CSS, JavaScript files

### Theme Customization

**Theme Customization** involves modifying the appearance and behavior of the website theme.

- **CSS**: Cascading Style Sheets for styling
- **JavaScript**: Programming language for interactivity
- **Templates**: HTML templates for page structure
- **Assets**: Images, fonts, and other media

### Build Process

**Build Process** converts source files into a deployable website.

- **Markdown Processing**: Convert Markdown to HTML
- **Asset Processing**: Process CSS, JavaScript, images
- **Template Rendering**: Apply templates to content
- **Static Generation**: Create static HTML files

## Development Terms

### Local Development

**Local Development** refers to developing and testing the website on your local machine.

- **Local Server**: Development server running locally
- **File Watching**: Automatic rebuilds when files change
- **Hot Reload**: Automatic browser refresh
- **Debug Mode**: Enhanced error reporting

### Version Control

**Version Control** is a system that tracks changes to files over time.

- **Git**: Distributed version control system
- **Commits**: Snapshots of changes
- **Branches**: Parallel lines of development
- **Merges**: Combining changes from different branches

### Continuous Integration/Continuous Deployment (CI/CD)

**CI/CD** is a set of practices that automate the process of building, testing, and deploying software.

- **GitHub Actions**: Automated workflows
- **Build Automation**: Automatic building of the site
- **Testing**: Automated testing of changes
- **Deployment**: Automatic deployment to production

### Link Checking

**Link Checking** is the process of verifying that all links on the website are working correctly.

- **External Links**: Links to external websites
- **Internal Links**: Links within the website
- **Markdown Links**: Links defined in Markdown files
- **Broken Links**: Links that no longer work

## Content Types

### Markdown

**Markdown** is a lightweight markup language for formatting text.

- **Syntax**: Simple syntax for formatting
- **Headers**: Different levels of headings
- **Links**: Hyperlinks to other pages
- **Images**: Embedded images
- **Code**: Inline and block code

### Front Matter

**Front Matter** is metadata at the top of Markdown files.

- **YAML**: YAML format for metadata
- **Title**: Page title
- **Date**: Publication date
- **Tags**: Categorization tags
- **Author**: Content author

### Templates

**Templates** are reusable page layouts that define the structure of pages.

- **HTML**: HyperText Markup Language
- **Jinja2**: Template engine used by MkDocs
- **Variables**: Dynamic content placeholders
- **Inheritance**: Template inheritance and overrides

### Assets

**Assets** are static files used by the website.

- **CSS**: Styling files
- **JavaScript**: Interactive functionality
- **Images**: Photos, diagrams, icons
- **Fonts**: Typography files

## Deployment Terms

### Static Site Generation

**Static Site Generation** creates a website from source files without requiring a server.

- **Pre-built**: All pages are built in advance
- **Fast Loading**: No server processing required
- **CDN Friendly**: Easy to serve from CDN
- **Secure**: No server-side vulnerabilities

### GitHub Pages

**GitHub Pages** is a static site hosting service provided by GitHub.

- **Free Hosting**: Free hosting for public repositories
- **Custom Domains**: Support for custom domain names
- **HTTPS**: Automatic HTTPS encryption
- **CDN**: Global content delivery network

### CDN

**CDN** (Content Delivery Network) is a network of servers that deliver content to users based on their geographic location.

- **Performance**: Faster loading times
- **Reliability**: Redundant servers
- **Global**: Worldwide content delivery
- **Caching**: Automatic content caching

### SSL/TLS

**SSL/TLS** (Secure Sockets Layer/Transport Layer Security) provides encryption for data transmitted over the internet.

- **HTTPS**: Secure HTTP protocol
- **Encryption**: Data encryption in transit
- **Certificates**: Digital certificates for authentication
- **Security**: Protection against eavesdropping

## Maintenance Terms

### Link Validation

**Link Validation** is the process of checking that all links on the website are working correctly.

- **Automated**: Automated checking tools
- **Manual**: Manual verification
- **Scheduled**: Regular checking schedules
- **Reporting**: Reports of broken links

### Content Updates

**Content Updates** involve modifying existing content on the website.

- **Editing**: Modifying existing content
- **Adding**: Adding new content
- **Removing**: Removing outdated content
- **Reorganizing**: Changing content structure

### Performance Optimization

**Performance Optimization** involves improving the speed and efficiency of the website.

- **Image Optimization**: Compressing and optimizing images
- **Code Minification**: Reducing file sizes
- **Caching**: Implementing caching strategies
- **CDN**: Using content delivery networks

### Security Maintenance

**Security Maintenance** involves keeping the website secure from threats.

- **Dependency Updates**: Updating software dependencies
- **Security Patches**: Applying security fixes
- **Vulnerability Scanning**: Checking for vulnerabilities
- **Access Control**: Managing user access

## Troubleshooting Terms

### Debug Mode

**Debug Mode** provides enhanced error reporting and logging for development.

- **Verbose Output**: Detailed error messages
- **Stack Traces**: Detailed error information
- **Logging**: Enhanced logging capabilities
- **Development**: Primarily for development use

### Error Handling

**Error Handling** is the process of managing and responding to errors that occur during website operation.

- **Graceful Degradation**: Website continues to function with errors
- **Error Messages**: User-friendly error messages
- **Logging**: Recording errors for debugging
- **Recovery**: Automatic error recovery when possible

### Rollback

**Rollback** is the process of reverting to a previous version of the website when problems occur.

- **Version Control**: Using Git to revert changes
- **Backup**: Restoring from backups
- **Emergency**: Quick response to critical issues
- **Testing**: Verifying rollback success

### Monitoring

**Monitoring** involves tracking the health and performance of the website.

- **Uptime**: Website availability monitoring
- **Performance**: Speed and efficiency tracking
- **Errors**: Error rate monitoring
- **Analytics**: Usage and traffic analysis

## Best Practices

### Code Quality

**Code Quality** refers to the maintainability, readability, and reliability of code.

- **Standards**: Following coding standards
- **Documentation**: Well-documented code
- **Testing**: Comprehensive testing
- **Review**: Code review processes

### Documentation

**Documentation** is written information about the website and its components.

- **User Guides**: Instructions for users
- **Developer Guides**: Instructions for developers
- **API Documentation**: Technical reference
- **Maintenance Guides**: Instructions for maintenance

### Testing

**Testing** is the process of verifying that the website works correctly.

- **Unit Testing**: Testing individual components
- **Integration Testing**: Testing component interactions
- **User Testing**: Testing with real users
- **Automated Testing**: Automated test execution

### Maintenance

**Maintenance** involves keeping the website updated and functioning correctly.

- **Regular Updates**: Scheduled maintenance tasks
- **Monitoring**: Continuous monitoring
- **Backup**: Regular backups
- **Documentation**: Keeping documentation current



