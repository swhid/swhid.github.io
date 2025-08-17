---
layout: page
title: Frequently Asked Questions (FAQs)
nav_order: 4
permalink: /faq/
---

## **Frequently Asked Questions (FAQ)**

### **🔍 What is a Software Hash IDentifier?**

A **Software Hash IDentifier (SWHID)** is a persistent, content-based identifier for software artifacts—such as source code files, directories, commits, releases, or repository snapshots. Each SWHID is computed from the artifact itself, using cryptographic hashing, without relying on any central authority. Note that for an artifact that contains other artifacts, the whole recursive content is taken into account (e.g., a directory and all its sub-directories, recursively; a commit, its entire source code tree and preceding commits, etc.) when computing its SWHID.

---


### **🌐 Why was the SWHID standardized?**

SWHID identifiers are described in the **ISO/IEC international standard (ISO/IEC 18670:2024)**.

Standardization helps to ensure **interoperability, verifiability, and traceability** across tools, platforms, and communities. Software developers around the world already rely on systems like Git, which use internally hash-based identifiers that are very similar to SWHID identifiers, and compatible with them to some extent. The **SWHID** standard makes this approach explicit and portable. That means the exact same artifact can be identified consistently, no matter the version control system or hosting platform.

---


### **🏛️ Why does this matter for institutions and regulators?**

SWHID identifiers enable:

- **Precise references** in scientific research and regulatory documents.

- **Stable and tamper-evident identifiers** for software artifacts in compliance, audits, and SBOMs (see also: “_How does SWHID relate to SBOMs?_” in this FAQ).

- **Cross-platform traceability**, regardless of repository hosting or naming conventions.

SWHID identifiers are already adopted by leading research infrastructures and referenced in cybersecurity policy frameworks like the European Union’s Cyber Resilience Act.

---


### **🗂️ How does the SWHID work with SBOMs?**

SWHID identifiers complement software bill of materials (SBOMs) by providing **cryptographic, content-based identifiers** that guarantee the integrity of each listed artifact. Unlike package names or version labels, a SWHID refers **exactly to a specific software artifact**, making it ideal for reproducibility and vulnerability management.

---


### **🛠️ How is the SWHID different from Git hashes?**

The SWHID standard **extends Git’s internal hashing logic** beyond the Git tool chain:

- SWHID identifiers can be **computed and verified independently** of Git tools, which is key for archival and regulatory use.

- SWHID identifiers are explicitly **annotated with artifact types**, making it visible what is being referenced.

- The **SWHID** standard uses qualified identifiers to add context—like file paths or line ranges. This makes it possible to trace specific software artifacts within a global archive like Software Heritage.

- In the current version 1 of the SWHID standard, a Git hash can be directly used to create a core SWHID for all kinds of artifacts except repository snapshots, because they cannot be explicitly referenced in Git.

---


### **🛠️ Are there existing implementations of the SWHID standard?**

Yes, we’re aware of several open-source implementations of the **SWHID** standard. \
They include:

- Command line tool and library, as part of the Python library [swh-model](https://gitlab.softwareheritage.org/swh/devel/swh-model/), by Software Heritage

- OCaml [swhid](https://github.com/OCamlPro/swhid) library, by OCamlPro

- Rust SWHID data type, as part of the [swh-graph](https://gitlab.softwareheritage.org/swh/devel/swh-graph) crate, by Software Heritage

- PEG.js grammar [swhid grammar tooling](https://github.com/barais/swhidgrammartooling), by Olivier Barais

If you know of other implementations, please [let us know](https://www.softwareheritage.org/contact/)!

---


### **🕰️ What happens if the original code disappears?**

SWHID identifiers can always be resolved in the **Software Heritage archive**, the largest public archive of source code. Even if the original repository is removed or rewritten, the identifier still resolves to the preserved artifact—ensuring **persistence and long-term verifiability**.

Keep in mind that an **SWHID**'s durability depends on the artifact it identifies being permanently archived. Always make sure the artifact is stored in Software Heritage or a similar service before you rely on the ID.

---


### **🧱 Why does SWHID use SHA-1?**

The first, and current, version of the SWHID standard (`swh:1:`) aligns with the **de facto practice used by Git**, which computes identifiers using a variant of SHA-1 (the hash is computed not on the byte sequence of the artifact itself, but on that byte sequence _prefixed with the length and the type of the artifact_). Building the SWHID standard on top of this approach ensures compatibility with the vast ecosystem of tools and repositories already relying on this convention—billions of commits in hundreds of millions of repositories contributed by tens of millions of developers rely on it daily.

The SWHID standard does not invent a new hash scheme—it **standardizes what developers already use**, bringing it into a consistent, verifiable, and archival-friendly format.

---


### **🔄 Will SWHID support newer hash functions in the future?**

Yes. The **SWHID** standard is designed to evolve: version identifiers in the scheme (`swh:1:...`, `swh:2:...`, etc.) clearly separate future upgrades. This ensures long-term security and forward compatibility, while preserving interoperability with existing systems.

---


### **🔐 Is SHA-1 still secure?**

SHA-1 is known to be vulnerable to **collision attacks**, but the SWHID standard applies SHA-1 in a specific context—identifying source code and development history, not signing or encrypting data. Following the best practices adopted by all Git based platforms today, **SWHID identifiers are calculated in a way that prevents collisions produced from currently known attacks to return valid identifiers**, using techniques such as structured preambles and collision detection tools. This is analogous to what recent versions of Git do—using the so-called “sha1collisiondetection” hashing scheme—in the wake of the SHAttered attack. The **SWHID** standard computes SHA-1 on payloads that are prefixed by their length (see: "Why does SWHID use SHA-1?"). This means that even in the case of a new attack, only collisions that do not alter the payload's length are theoretically possible.

We recognize that **no hash function is future-proof**, which is why the SWHID standard includes an **explicit version number** (`swh:1:...`) that allows smooth upgrades to stronger hash algorithms in future versions.
