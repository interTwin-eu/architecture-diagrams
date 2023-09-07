# Conceptual Model

The blueprint architecture provides an overall framework for the *Digital Twin Engine* (*DTE*), defining its boundaries and its interfaces with the surrounding environment based on building blocks.

The *DTE* is designed to be an open-source integrated platform based on open standards, APIs and protocols that offers the capability to integrate with application-specific *Digital Twins* (*DTs*). Its functional specifications and implementation are based on a co-designed interoperability framework and conceptual model of the *DT* for research.

The blueprint architecture is an instrument to introduce a level of abstraction that is sufficient to meet the requirements of the use cases for which different *DTs* are designed. As illustrated in the next figure (*interTwin* *DTE* conceptual model), the *interTwin* *DTE* is organised in three functional areas: Infrastructure, Core and Thematic capabilities.

![*interTwin* *DTE* conceptual model](./conceptual_model.png)
[*interTwin* *DTE* conceptual model (click to edit)](https://excalidraw.com/#json=YlztyRuK4EUvPbPzugPLj,KJjDc28uzawcvC7lsTOmag)

Based on open-source software components, the *DTE* is designed to adhere to standard principles summarised as follows:

* Standard-based Integration and portability: The *DTE* is designed to provide end-to-end integration and a 'one-stop-shop' for domains and target groups also outside the project use cases. (SMEs, industry, and evidence based policy makers). This will require a progressive shift of *DT* applications from the development of in-house solutions towards an increasing adoption and development of common open source modules.
* Extensibility and modularity: Interfaces (e.g., APIs and GUIs) need to decouple the *DTE* from the *DT* applications implemented.
* Scalability and sustainability: The *DTE* has to integrate with application-specific data and compute facilities. It needs to integrate with current/future infrastructures from national to pan-European level, such as the European Open Science Cloud. The *DTE* infrastructure is sustained by investments in digital infrastructures.
* PaaS and SaaS provisioning: The *DTE* needs to provide a *Platform-as-a-Service* (*PaaS*) layer for development of custom applications and creating a user work environment integrating relevant data to be accessed by the modelling and simulation tasks and *Software-as-a-Service* (*SaaS*) layer for consuming the functionalities of the *DTs* as dedicated services.

This system encompasses two primary user groups: Developers and Users, the latter being  primarily scientists using existing *DT* applications for their research or policy makers.

Developers engage with the interTwin *PaaS*, developing *DT* applications and occasionally thematic modules that offer new domain-specific tools and best practices. These are subsequently translated into workflows by an underlying composition tool. The applications crafted by *DT* developers are in response to researchers' needs and are made accessible to users as *SaaS*.

Users have the option to select a pre-made *DT* application and connect it to their specific use case, or they can re-train it if necessary. The interactions between the Users and the *DT* application are facilitated through a user interface provided by the specific *DT* application.

Part of the *DTE* architecture includes an infrastructure *DT* provider that offers computational resources, storage, and a connection with the *physical twin* (*PT*) existing in the real world. This connection may occasionally require the use of intermediate infrastructures, such as satellites or particle detector sensors, typically situated near the use case. These intermediate infrastructures are necessary to filter, preprocess, or buffer the real-time data collected from the PT before it is processed by the infrastructure *DT* provider.

The security of *DTs* is essential to prevent a range of potential risks. These include unauthorised access, which could lead to manipulation or theft of data; threats to availability, which could cause disruptions in operations; durability risks, which could result in loss of data or system failures; and performance risks, which could adversely impact the efficiency and effectiveness of the *DT*'s simulations. Consequently, robust measures are required to safeguard against these varied types of security threats, as a compromised digital twin can lead to significant issues, both in the virtual and real world.

Tha *Authentication and Authorization Infrastructure* (*AAI*) is key for Users, Developers and Providers, and represents an integral part of the *DTE* infrastructure. Key features of *AAI* include: data protection, integrity of simulations and workflows, trust and compliance, and securing interconnected systems (i.e., infrastructure).


Nota: Quiza falta añadir lo de User Interface de los usuarios, un texto que hable de que el objetivo es que otras plataformas compatibles se puedan conectar, y un dibujo de la parte de la infrastructura donde se conectan con el PT.
