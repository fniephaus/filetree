utilities
loadDependencies
  | dependencyDir directoryPath |
  directoryPath := self monticelloMetaDirName
    , self fileUtils pathNameDelimiter asString , 'dependencies'.
  dependencyDir := self fileUtils
    directoryFromPath: directoryPath
    relativeTo: packageDirectory.
  (self fileUtils directoryExists: dependencyDir)
    ifFalse: [ 
      dependencies := #().
      ^ self ].
  dependencies := OrderedCollection new.
  dependencyDir entries
    do: [ :entry | 
      dependencies
        add:
          (MCVersionDependency
            package: (MCPackage named: entry name)
            info: (self extractDependencyInfoFor: entry name)) ].
  dependencies := dependencies asArray