workspace "Federated Data Management" "Diagrams that show how data is handled in the interTwin project" {

    !impliedRelationships false

    model {
        user = person Researcher "Scientist wishing to use the DTE" {
            tags "Human"
        }

        ingestor = person "Data Ingestor" "Automated process for adding new data" {
            tags "Robot"
        }

        wp6 = softwareSystem "DTE Core Modules" {
	    tags "External Software System"
            description "WP6: support data fusion, and real-time \
                acquisition and processing"
        }

        wp7 = softwareSystem "DTE Thematic Modules" {
	    tags "External Software System"
            description "WP7: Specific thematic modules for individual \
                domains"
        }

        storage1 = softwareSystem "Storage at facility #1" {
            tags "storage" "External Software System"

            description "The storage capacity at a facility that has \
                been made available for the user/group"
        }

        storage = softwareSystem "Storage" {
            tags "storage" "External Software System"

            description "Some arbitrary storage capacity at some \
                facility that has been made available for the \
                user/group"
	}

        storage_local = softwareSystem "Storage (local)" {
            tags "storage" "External Software System"

            description "The storage capacity at a facility that has \
                been made available for the user/group"
        }

        storage2 = softwareSystem "Storage at facility #2" {
            tags "storage" "External Software System"

            description "The storage capacity at a facility that has \
                been made available for the user/group"
        }

	external_catalogue = softwareSystem "Community catalogue" {
	    tags "External Software System"

	    description "A science-community catalogue that defines datasets.  This \
                may include dataset metadata and dataset locality."
	}

        storage_dcache = softwareSystem "dCache storage" {
            tags "storage" "dCache" "External Software System"
        }

        user -> wp6 "Possible direct use of DTE-core services" {
            tags "maybe, curved"
        }

        user -> wp7 "Engage with thematic digital twin apparatus" {
            tags "definitely"
        }

        ingestor -> storage "Writes data" {
            tags "definitely, curved"
	}

        group wp5 {

            wp5_3 = softwareSystem "Federated Services and policies" {
		tags "WP5" "Internal Software System"
                description "Task 5.3: resource accounting"
            }

            wp5_4 = softwareSystem "AI-based orchestrator" {
		tags "WP5" "Internal Software System"
                description "Task 5.4: PaaS Orchestrator; dynamic data \
                    infrastructure deployment."
            }

            wp5_1 = softwareSystem "Federated compute infrastructure" {
		tags "WP5" "Internal Software System"
                description "Task 5.1: grants access to compute \
                    resources, customises runtime environments, \
                    deploys network configuration."
            }

            wp5_2 = softwareSystem "Federated data infrastructure" {
		tags "WP5" "Internal Software System"
		
                description "Task 5.2: provides an abstraction layer \
                    for data access, managing data locality and \
                    signalling when new data arrives."

                technology_agnostic = container "Storage technology abstraction" {
                    tags "WP5"
                    description "Hides details of technology"

                    wp5_2_gfal = component "Storage agnostic library" {
                        tags "WP5"
                        description "A pluggable framework that \
                            exposes POSIX-like API; running at \
                            facility #1"

                        technology "gfal2"
			tags "CERN-grid-tools"
                    }

                    wp5_2_plugin_local = component "Direct access plugin" {
                        tags "WP5"
                        description "A plugin for optimised for local access"
                    }

                    wp5_2_plugin_remote = component "Network protocol plugin" {
                        tags "WP5"
                        description "A plugin that supports a supported protocol"
			technology davix
			tags "CERN-grid-tools"
                    }

                    wp6 -> wp5_2_gfal "Technology-agnostic data requests" {
		        tags "definitely"
		    }

		    wp5_2_gfal -> wp5_2_plugin_local "Delegated requests" {
		        tags "definitely"
		    }

                    wp5_2_gfal -> wp5_2_plugin_remote "Delegated requests" {
		        tags "definitely"
		    }

		    wp5_2_plugin_local -> storage_local "Direct access" {
		        tags "definitely"
		    }
		}

		edge_service_remote = container "Storage edge service (remote)" {
                    tags "WP5"

                    description "Service deployed at some other facility."
                }


                edge_service_1 = container "Storage edge service #1" {
                    tags "WP5"

                    description "Service deployed \"close\" to \
                        storage service #1, so that direct storage \
                        access is possible."
                }

                edge_service_2 = container "Storage edge service #2" {
                    tags "WP5"

                    description "Service deployed \"close\" to \
                        storage service #2, so that direct storage \
                        access is possible."
                }

                wp5_2_plugin_remote -> edge_service_remote "Remote access" {
                    tags "maybe"
                }

                dataset_mngmt = container "Dataset management" {
                    tags "WP5"

                    description "Support for dataset location \
                        discovery, placement/movement and for storing \
                        dataset metadata."

                    wp5_2_rucio = component "Dataset orchestration" {
                        tags "WP5"
                        description "Dataset placement and metadata"
                        technology "Rucio"
			tags "Rucio"
                    }

                    wp5_2_dataset_bus = component "Dataset notification" {
		        description "A dataset notification bus, used \
                            to deliver dataset lifecycle events"
			tags "Message bus"
		    }

                    wp5_2_fts = component "File transfer" {
                        tags "WP5"
                        description "A component that is responsible \
                            for transferring individual files between \
                            different storage systems"
                        technology "FTS"
			tags "FTS"
                    }

		    wp6 -> wp5_2_rucio "Adjust data locality rule" {
		        tags "definitely"
		    }

                    wp5_2_rucio -> wp5_2_fts "List of files to transfer" {
		        tags "definitely"
		    }

		    wp5_2_rucio -> wp5_2_dataset_bus "Notify" {
		        tags "definitely"
		    }

                    wp5_2_fts -> edge_service_1 "Initiate transfer (if push)" {
		        tags "maybe"
		    }

                    wp5_2_fts -> edge_service_2 "Initiate transfer (if pull)" {
		        tags "definitely"
		    }

		    wp5_2_fts -> wp5_2_dataset_bus "Notify" {
		        tags "definitely"
		    }

		    wp5_2_dataset_bus -> wp6 "Notify" {
		        tags "maybe, curved"
		    }

                    wp5_1 -> wp5_2_rucio "Manage rules" {
		        tags "definitely"
		    }

		    wp5_4 -> wp5_2_rucio "Manage rules" {
		        tags "definitely"
		    }

		    wp5_2_dataset_bus -> wp5_4 "Notify" {
		        tags "definitely"
		    }

                    edge_service_1 -> edge_service_2 "Data is transferred." {
		        tags "definitely"
		    }

                    external_catalogue -> wp5_2_rucio "Provide dataset metadata" {
                        tags "maybe"
                    }
                }

                new_data_notification = container "New data notification" {
                    tags "WP5"
                    description "Support for discovering the availability of new data."

		    wp5_2_subscription_mgmnt = component "Subscription management" {
		        tags "WP5"
		        description "Central component for managing \
		            subscriptions"
		    }

		    wp5_2_message_bus = component "Event delivery" {
                        tags "WP5"
                        description "A message bus for delivering \
                            notification of new data"
			tags "Message bus"
		    }

		    wp5_2_polling_agent = component "Polling agent" {
                        tags "WP5"
                        description "A service that queries the \
                            file-system under some schedule (e.g., \
                            periodically) to look for the presence of \
                            new data."
		    }

		    wp5_2_storage_event = component "Storage event manager" {
                        tags "WP5"
                        description "A service that manages storage \
		            event subscriptions.  Storage events are \
		            delivered asynchronously."
		    }

		    wp6 -> wp5_2_subscription_mgmnt "Manage which directories are being monitored" {
		        tags "definitely"
		    }

		    wp5_2_subscription_mgmnt -> wp5_2_message_bus "Manage topics" {
		        tags "definitely"
		    }

		    wp5_2_subscription_mgmnt -> wp5_2_storage_event "Update subscriptions" {
		        tags "definitely"
		    }

		    wp5_2_subscription_mgmnt -> wp5_2_polling_agent "Update subscriptions" {
		        tags "definitely, curved"
		    }

		    storage_dcache -> wp5_2_storage_event "Storage events" {
		        tags "definitely"
		    }

		    wp5_2_polling_agent -> edge_service_remote "stat(2)-like request" {
		        tags "definitely"
		    }

		    wp5_2_storage_event -> wp5_2_message_bus "Announce new data" {
		        tags "definitely, curved"
		    }

		    wp5_2_polling_agent -> wp5_2_message_bus "Announce new data" {
		        tags "definitely"
		    }

		    wp5_2_message_bus -> wp6 "New data notification" {
		        tags "definitely"
		    }
                }

                edge_service = container "Storage edge service" {
                    tags "WP5"

                    description "Service deployed \"close\" to a \
                        storage service, so that direct storage \
                        access is possible."

		    edge_service_reverse_proxy = component "Reverse proxy" {
		        description "Receive incoming requests; \
		            authentication."
		    }

		    edge_service_webdav_manager = component "WebDAV service manager" {
		        description "Component responsible for \
		            starting and stopping user-specific WebDAV \
		            instances."
		    }

 		    edge_service_accounting = component "Report generator" {
                        description "Generates periodic storage-usage \
                            reports."
                    }

		    edge_service_identity_mapper = component "Identity mapping" {
		        tags "WP5"

		        description "Handle the translation of \
		            federated identities to local identities"
		    }

                    group "Components running with a user's identity" {
                        edge_service_webdav_1 = component "WebDAV server for identity #1" {
                            tags "WP5"
                            description "A component that processes WebDAV requests."
                            technology "StoRM WebDAV"
                            tags "StoRM"
                       }

                        edge_service_webdav_2 = component "WebDAV server for identity #2" {
                            tags "WP5"
                            description "A component that processes WebDAV requests."
                            technology "StoRM WebDAV"
                            tags "StoRM"
                        }
			
			edge_service_agent = component "Usage agent" {
                            description "Obtains usage information."
                        }
                    }

 		    edge_service_reverse_proxy -> edge_service_webdav_manager "Query identity-specific WebDAV endpoint" {
		        tags "definitely, direct"
		    }

 		    edge_service_identity_mapper -> edge_service_reverse_proxy "Provide user's local identity" {
		        tags "definitely, direct"
		    }

 		    edge_service_webdav_manager -> edge_service_webdav_1 "Lifecycle management" {
		        tags "definitely, direct"
		    }

 		    edge_service_webdav_manager -> edge_service_webdav_2 "Lifecycle management" {
		        tags "definitely, curved"
		    }

 		    edge_service_reverse_proxy -> edge_service_webdav_1 "Requests with identity #1" {
		        tags "definitely, curved"
		    }

 		    edge_service_reverse_proxy -> edge_service_webdav_2 "Requests with identity #2" {
		        tags "definitely, direct"
		    }

		    technology_agnostic -> edge_service_reverse_proxy "Remote access to data" {
		        tags "maybe, direct"
		    }

		    dataset_mngmt -> edge_service_reverse_proxy "Initiate third-party transfer" {
		        tags "definitely, direct"
		    }

		    edge_service_remote -> edge_service_webdav_1 "Transferring data (pull) for user 1" {
		        tags "definitely"
		    }

		    edge_service_webdav_1 -> storage_local "Direct filesystem access" {
		        tags "definitely"
		    }

		    edge_service_webdav_2 -> storage_local "Direct filesystem access" {
		        tags "definitely"
		    }
		    
		    storage_local -> edge_service_agent "Provide usage information" {
		        tags "definitely, ortho"
		    }
		    
 		    edge_service_identity_mapper -> edge_service_accounting "Provide list of identities" {
		        tags "definitely"
		    }

		    edge_service_agent -> edge_service_accounting "Provide usage information" {
		        tags "definitely"
		    }
		    
		    edge_service_accounting -> wp5_3 "Provide usage information" {
		        tags "definitely"
		    }
                }

		wp5_1 -> dataset_mngmt "Ready datasets for analysis" {
		    tags "definitely, direct"
		}

		wp5_4 -> dataset_mngmt "Ready datasets for analysis" {
		    tags "definitely, direct"
		}

 		new_data_notification -> wp6 "Notification of new data" {
		    tags "definitely, direct"
		}

 		wp6 -> technology_agnostic "Technology-agnostic data access" {
		    tags "definitely, direct"
		}

                external_catalogue -> dataset_mngmt "Provide dataset metadata" {
                    tags "maybe"
                }

 		wp6 -> dataset_mngmt "Preparing data for use" {
		    tags "definitely"
		}

                new_data_notification -> edge_service "Poll for new data" {
		    tags "definitely, curved"
		}

                storage_dcache -> new_data_notification "Storage events" {
		    tags "definitely"
		}

                edge_service -> storage "Direct access" {
		    tags "definitely"
		}

                edge_service -> wp5_3 "Provide usage records" {
		    tags "definitely"
		}

                technology_agnostic -> storage "Direct access" {
		    tags "definitely"
		}

                technology_agnostic -> edge_service "Remote access" {
		    tags "maybe"
		}

                dataset_mngmt -> storage_dcache "Initiate transfer" {
		    tags "definitely, curved"
		}

                dataset_mngmt -> edge_service "Initiate transfer" {
		    tags "definitely"
		}
            }

            wp5_1 -> wp5_2 "Inferred data management" {
                tags "definitely"
            }

            wp5_4 -> wp5_2 "Inferred data management" {
                tags "definitely"
            }

            wp5_2 -> wp5_3 "Accounting reports" {
	        tags "definitely"
	    }

            external_catalogue -> wp5_2 "Provide dataset metadata" {
                tags "maybe"
            }
        }

        wp7 -> wp5_2 "Thematic explicit data management" {
            tags "maybe, curved"
        }

        wp6 -> wp5_1 {
            tags "definitely"
        }

        wp6 -> wp5_2 "DTE-core explicit data management" {
            tags "definitely, curved"
        }

        wp6 -> wp5_4 {
            tags "definitely"
        }

        wp7 -> wp6 {
            tags "definitely"
        }

        wp5_2 -> storage "Manages storage" {
            tags "definitely"
        }
    }

    views {
        systemLandscape wp5-landscape "Shows WP5 sytem components in general landscape of interTwin"{
            include *
	    exclude storage_dcache storage_local storage1 storage2
            default
        }

        systemContext wp5_2 wp5_2-context "Shows the federated data infrastructure context" {
            include *
        }

        container wp5_2 wp5_2-container "Shows the federated data infrastructure containers" {
            include *
	    exclude edge_service_1 edge_service_2 edge_service_remote
	    exclude "wp6 -> wp5_1"
	    exclude "wp6 -> wp5_4"
        }

        component dataset_mngmt dataset-management "Shows the dataset management" {
            include *
	    exclude "technology_agnostic -> edge_service_1"
	    exclude "technology_agnostic -> edge_service_2"
	    exclude "wp6 -> technology_agnostic"
	    exclude "wp6 -> wp5_1"
	    exclude "wp6 -> wp5_4"
        }

	component technology_agnostic technology-agnostic "Shows layer for hiding storage technology" {
	    include *
	}

 	component new_data_notification new-data-notification "Shows how new data is announced" {
	    include *
	}

	component edge_service edge-service "Shows how remote access is supported" {
	    include *
	    exclude "technology_agnostic -> dataset_mngmt"
	    exclude "technology_agnostic -> storage1"
	}

        styles {
	    element "FTS" {
	        icon images/FTS.png
	    }
	    element "CERN-grid-tools" {
	        icon images/grid-tools.png
	    }
	    element "Rucio" {
	        icon images/rucio.png
	    }
	    element "StoRM" {
	        icon images/StoRM.png
	    }
	    element "dCache" {
	        icon images/dCache.png
	    }
            element "storage" {
                shape Cylinder
            }
	    element "Message bus" {
	        shape Pipe
	    }
            relationship "definitely" {
                color #000000
                dashed false
            }
            relationship "maybe" {
                color #444444
                dashed true
            }
            relationship "ortho" {
		routing Orthogonal
            }
            relationship "curved" {
		routing Curved
            }
            relationship "direct" {
		routing Direct
            }
        }

	branding {
	    logo images/interTwin.png
	    font "Open Sans"
        }
	
        theme default	
    }
}
