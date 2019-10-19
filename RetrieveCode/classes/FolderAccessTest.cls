public with sharing class FolderAccessTest {

  public Integer totalFolders {get;set;}

  public List<Folder> getFoldersForReports() 
  {
      List<Folder> folders = [select Id, Name from Folder 
      where Type = 'Report' and Name != null and DeveloperName != null order by Name];

    totalFolders = folders.size();

    return folders;
  }
}