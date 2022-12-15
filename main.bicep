@description('Location which the resources will be created at.')
param location string = resourceGroup().location

@description('The globally unique name for the sql server.')
param sqlServerName string = 'usersdbnz'

@description('The username for the database.')
param adminUsername string = 'dbadmin'

@description('The password for the database.')
@secure()
param adminPassword string

@description('The name of the database.')
param sqlDatabaseName string = 'UsersDatabase'

resource sqlserver 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
    publicNetworkAccess: 'Enabled'
    minimalTlsVersion: '1.2'
  }
}

resource sqldatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlserver
  name: sqlDatabaseName
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    isLedgerOn: false
    maxSizeBytes: 524288000
    sampleName: ''
    zoneRedundant: false
    licenseType: ''
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Local'
  }
  sku: {  
    name: 'S0'
    tier: 'Standard'
  }
}
