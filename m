Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA68134F462
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664055; cv=none; b=l94tI68c8YIUapJqcOCqZ4rXUNEGAU6ATtLaN5DNu/1lzAU5h67ZUw43r7b1eLhr7XjAq39OxSP0RO9I6WxfPKE+QfVCqTwjMTFwoifd2yaiolC2a4Qyo8uVfRphx2zdeItP15IKAEhgmKOJhJ62RYrIRvkYroGS/j7emH6XCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664055; c=relaxed/simple;
	bh=3MFSYpCB1vJ0eEz9Y9IqL126JHgjZBgyuJdxXIGwp+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siI77w9AS45vmCSGqWk97UCEWS6qTfd7bSwA1LDKDbYoQICN2G+PSkYNrFFnofoMDXo83z2RdmF5cz0ca6hzareSuaHmFs+9npv1bm/QlZQ3TvPGLZjmVaZf3xQN4Gs/+Wtxuc3SbkIZQwJAaNiFgc8viUpkZ/qbKunG16fiXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B16F3339;
	Mon, 16 Mar 2026 05:27:25 -0700 (PDT)
Received: from [10.1.28.15] (e127648.arm.com [10.1.28.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596943F73B;
	Mon, 16 Mar 2026 05:27:30 -0700 (PDT)
Message-ID: <c6857071-214d-403f-9c34-07a095e96e13@arm.com>
Date: Mon, 16 Mar 2026 12:27:28 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-7.1 0/2] sched_ext: Reduce idle CPU NUMA
 traversal from O(N^2) to O(N)
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
References: <20260315181017.1377138-1-yphbchou0911@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260315181017.1377138-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/26 18:10, Cheng-Yang Chou wrote:
> pick_idle_cpu_from_online_nodes() uses for_each_node_numadist() which
> performs an O(N^2) traversal on every call to find the nearest idle
> CPU across NUMA nodes.
> 
> Since NUMA distances are fixed at boot and do not change at runtime,
> the per-node traversal order can be computed once during initialization
> and reused on every subsequent call. This series pre-computes the
> sorted order into scx_numa_node_order[], reducing the per-call cost
> to O(N).
> 
> Patch 1 allocates and populates scx_numa_node_order[] and
> scx_numa_node_order_cnt[] in scx_idle_init_masks() using the existing
> for_each_node_numadist() traversal, paying the O(N^2) cost only once
> at init time.
> 
> Patch 2 switches pick_idle_cpu_from_online_nodes() to iterate the
> cached arrays, removes the now-unnecessary per_cpu_unvisited nodemask,
> and adds a node_online() check so CPU hotplug is handled correctly
> without needing to rebuild the arrays.
> 
> Tested with make -j only. I do not have access to a NUMA machine to
> run runtime tests.

qemu can at least functionally test that using something like
-smp 8,sockets=2,clusters=2,cores=2,threads=1
