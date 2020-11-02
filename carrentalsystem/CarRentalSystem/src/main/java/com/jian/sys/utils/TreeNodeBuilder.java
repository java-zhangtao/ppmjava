package com.jian.sys.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * 构建层级关系的工厂
 */
public class TreeNodeBuilder {
    public static List<TreeNode> builder(List<TreeNode>treeNodes,Integer topPid){
        List<TreeNode> nodes=new ArrayList<>();
        for (TreeNode n1 : treeNodes) {
            if(n1.getPid()==topPid){
                nodes.add(n1);
            }
            for (TreeNode n2 : treeNodes) {
                if(n2.getPid()==n1.getId()){
                    n1.getChildren().add(n2);
                }
            }
        }
        return nodes;
    }
}
