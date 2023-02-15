INSERT INTO `aws_costs` (`Group hierarchy`, `Region`, `Description`, `Service`, `Upfront`, `Monthly`, `First 12 months total`, `Currency`, `Configuration summary`) VALUES
	('My Estimate', 'US East (Ohio)', '', 'Amazon RDS for PostgreSQL', '0', '266.78', '3201.36', 'USD', '"Storage volume (General Purpose SSD (gp2)), Storage amount (30 GB per month), Nodes (1), Instance Type (db.m5.large), Utilization (On-Demand only) (100 %Utilized/Month), Deployment Option (Multi-AZ), Pricing Model (OnDemand)"'),
	('My Estimate', 'US East (Ohio)', 'route53 aws hosted zones', 'Amazon Route 53', '0', '5', '60.00', 'USD', 'Hosted Zones (10)'),
	('My Estimate > myapp', 'US East (Ohio)', 'webserver', 'Amazon EC2', '0', '64.53999999999999', '774.48', 'USD', '"Operating system (Linux), Quantity (1), Pricing strategy (EC2 Instance Savings Plans 1 Year No UpFront), Storage amount (30 GB), Instance type (t4g.xlarge)"'),
	('Global', 'All', 'Business support plan', 'AWS Support', '0', '100', '1200.00', 'USD', '"Supports 24/7 phone, chat, and email access to Cloud Support Engineers for unlimited contacts, with and a response time of less than 1 hour."');
