require 'gviz'

def tab2graph(strarray)
	#p strarray
	res=[]
	for x in 0..strarray.length-1 do
		str=strarray[x]
		level = str.length-(str.lstrip.length)
		p "#{str}:#{level}"
		if level == 0
			p = nil
		elsif level-res[x-1][:level]<=0
			p = res[x-1][:parent]
			for i in 0..res[x-1][:level]-level
				p = res[p]["parent"]
				if p.nil?
					p=0
					break
				end
			end
		else
			p = x-1
		end
		res.push({:id => x,:node => str.strip,:level => level,:parent => p})
	end
	return res
end




def grap2png(graph)
	gv = Gviz.new
	
	graph.each do |n|
		if n[:parent].nil?
		else
			p "#{graph[n[:parent]][:node]} #{n[:node]}"
			gv.add :"#{graph[n[:parent]][:node]}" => :"#{n[:node]}"
		end
	end
	
	gv.save :sample,:png
end


test = []
# test.push("root")
# test.push(" hoge1")
# test.push(" hoge2")
# test.push("  hoge21")
# test.push("   hoge211")#illigal
# test.push(" hoge3")
# test.push("  hoge31")
# test.push("   hoge311")
# test.push(" hoge4")
# test.push("  hoge41")
# test.push("   hoge411")#illigal
# test.push("root2")
# test.push(" huga1")

f=open($0){|file|
	while l=file.gets
		test.push(l)
}

t2g=tab2graph(test)
grap2png(t2g)

