package com.antt.ghichu;

import java.io.File;
import java.util.LinkedList;
import java.util.List;

public class FileSplitter {
	final private File path;

    public List<String> getPathStrings()
    {
        LinkedList<String> list = new LinkedList<String>();
        File p = this.path;
        while (p != null)
        {
            list.addFirst(p.getPath());
            p = p.getParentFile();
        }
        return list;
    }

    public FileSplitter(File path) { this.path = path; }
}
