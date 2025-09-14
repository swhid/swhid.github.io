---
title: Homepage
layout: page
nav_order: 0
---

# SWHID: International Standard for Software Artifact Identification

SWHIDs (from “SoftWare Hash IDentifiers”) are persistent, intrinsic identifiers for software source code artifacts such as source code files, source trees, commits, and other objects typically found in version control systems.

<div class="swhid-banner">
  <h2>SWHID is an ISO International Standard</h2>
  <p><strong>SWHID has been officially adopted as ISO/IEC 18670:2025</strong> on April 23, 2025.</p>
  <p>The first international standard for persistent, content-based identification of software artifacts.</p>
  <a href="https://www.iso.org/standard/89985.html" class="btn" target="_blank">View ISO Standard</a>
  <a href="/specification/" class="btn" target="_blank">Read Public Specification</a>
  <a href="/faq/" class="btn" target="_blank">FAQ</a>
</div>

## What are SWHIDs?

**SWHIDs** (SoftWare Hash IDentifiers) are persistent, intrinsic identifiers for software source code artifacts such as source code files, source trees, commits, and other objects typically found in version control systems.

### Key Benefits

- **🔒 Cryptographic Integrity**: Based on Merkle DAGs for tamper-proof identification
- **🌐 Decentralized**: No central registry required - anyone can verify identifiers
- **📚 Comprehensive**: Covers files, directories, commits, releases, and snapshots
- **🔗 Provenance**: Enables complete traceability of software artifacts
- **⚡ Fast**: Efficient computation and verification algorithms

## The SWHID Working Group

The SWHID Working Group oversees development of the SWHID materials in the [SWHID GitHub repositories](https://github.com/swhid), including:

- **📋 The SWHID specification** - The official technical standard
- **🛠️ Software libraries and tools** - Reference implementations and utilities
- **📖 Documentation and resources** - Examples, guides, and adoption stories

### Quick Access

<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin: 2rem 0;">
  <div class="news-item">
    <h3>📋 Specification</h3>
    <p>Access the complete technical specification and reference documentation.</p>
    <a href="/specification/" class="btn btn-outline">View Specification</a>
  </div>
  <div class="news-item">
    <h3>📰 Latest News</h3>
    <p>Stay updated with announcements, releases, and community updates.</p>
    <a href="/news/" class="btn btn-outline">Read News</a>
  </div>
  <div class="news-item">
    <h3>📚 Publications</h3>
    <p>Academic papers, white papers, and technical publications about SWHID.</p>
    <a href="/publications/" class="btn btn-outline">Browse Publications</a>
  </div>
  <div class="news-item">
    <h3>👥 Core Team</h3>
    <p>Meet the maintainers and contributors behind the SWHID standard.</p>
    <a href="/coreteam/" class="btn btn-outline">Meet the Team</a>
  </div>
</div>

## Participation and Governance

Participation in the elaboration of the SWHID standard is open to all. Design and planning is primarily done via the team [mailing list](https://groups.google.com/g/swhid-discuss) (see [how to join][howto-join]) and regular meetings.

The SWHID specification is maintained by the [SWHID core team](/coreteam/) and follows the principles stated in [the governance document](https://swhid.org/governance/) maintained in the [governance repository](https://github.com/swhid/governance/).

These principles follow the model proposed by the [Community Specification](https://github.com/CommunitySpecification/Community_Specification), developed via the [Joint Development Foundation](http://www.jointdevelopment.org) (now part of the [Linux Foundation](https://www.linuxfoundation.org/)), with inspiration from the [Open Web Foundation agreements](http://openwebfoundation.org) and the [Alliance for Open Media Patent License 1.0](http://aomedia.org/license/patent-license/).

## Getting Started

### For Developers
- **📖 Read the [specification](/specification/)** to understand the technical details
- **🔧 Check out [implementations](https://github.com/swhid)** for your programming language

### For Researchers
- **📚 Browse [publications](/publications/)** for academic papers and research
- **📊 Explore [use cases](https://www.softwareheritage.org/how-to-archive-reference-code/)** in software preservation

### Onboarding Material

A dedicated webinar has been held to help onboarding participants to this working group. The material is available online, and newcomers are encouraged to start here:

- [📊 Support slides](https://hal.science/hal-04121507) used during the webinar
- [🎥 Recording](https://annex.softwareheritage.org/public/talks/2023/2023-03-27-SWHID-kickoff.mp4) including an extensive Q&A session

[howto-join]: https://support.google.com/a/users/answer/9304806
