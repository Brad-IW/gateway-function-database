@description('Location which the resources will be created at.')
param location string = resourceGroup().location

// Must be unique.
var sqlServerName = 'usersdbnz' 
var sqlDatabaseName = 'sqlDatabaseName'
var adminUsername = 'dbadmin'
var adminPassword = 'ThIsIsNoTsEcUrE1234321'

resource sqlserver 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
    publicNetworkAccess: 'Disabled'
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
    name: 'Standard'
    tier: 'S0'
  }
}
