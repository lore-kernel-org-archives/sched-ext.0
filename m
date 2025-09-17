Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C92192F2;
	Wed, 17 Sep 2025 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075158; cv=none; b=QGczmwtY3aE88bxcn+TN+wpIShkgIQ3zTbjMSzH4Afru8fawZeIKmxL2dosQ4trIbaBiCyjXGCurUWBn3UdvSXoL96h4qQrXTsJ3m+rpYLVRtwOkmJr2WGBJ0qbBI/KVf1CDtjTXjRASP5AWpSPGeAOhmjMf5mr5ezTYVhsWe/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075158; c=relaxed/simple;
	bh=o7B2mZHPWT/aZdNVmEU0SN6olLzQWfJsVaSsEW6Dp44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDfSzd9iI+EAmP0O/gO3JPTk6UFn+Dfnq11fqToMfhSGiAFNFXTjfBU4pXyjZX9aqCpTL+ReM5Na2ZtFSWoh/9rWH9hKR8PXml3nVagB0q+1mfmqI78LVtwV8c9+aWz8aScpmCh21CMgjOWZqpBovQOd4wZop1XkjdIPH9Futxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aXV2X5Kf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aXV2X5Kf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oTAMKDMleRnfi2Q+zweyRqDXxRH9gs+cg8KcwQjTdOk=; b=aXV2X5KfybjG+NdBAlSbb1geMi
	PapCNN5AlvZuKC96YbVn6VMFwr4xu/DRBNoMV18Bkfwpw/cRM0+RM0SZMmrFZI7re3Udc70kHz9DP
	C2+b1cuLR9N0WNFBXaqekw9DWpL3i0y6q2ZIJnJ4Hd3nnNVxAvit0hld+Sb+eUqGCJc/WIVAAANGI
	1h/ZxoR2NID3RfF1Jb/6Nh9Pp7k12ym6Ls568YevSY8c7Ow1Y7r1sd+cSLJiOaQsFaU1EHUfN7pwx
	sV+IXhU8XqUy9iaeQt4+4lRcsuzRlCIA0+ad31qrWgONCRzRWD5cOthceBRfDqb3Q7Aq15xjCkh5O
	FytUT5iA==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uyhej-00CWDi-KH; Wed, 17 Sep 2025 04:12:26 +0200
Message-ID: <2ef92808-42c9-4f8b-9d58-11e5d2c89fc3@igalia.com>
Date: Wed, 17 Sep 2025 11:12:18 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: allow scx_bpf_task_cgroup() in ops.dispatch()
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250915065236.13669-1-changwoo@igalia.com>
 <aMnJRn8qdiFaqQXU@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <aMnJRn8qdiFaqQXU@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Tejun,

Thanks for the feedback.

On 9/17/25 05:32, Tejun Heo wrote:
> Hello,
> 
> On Mon, Sep 15, 2025 at 03:52:36PM +0900, Changwoo Min wrote:
> ...
>> Fix this by adding the prev task to scx.kf_tasks so that task-related
>> BPF helpers such as scx_bpf_task_cgroup() can be called safely. Since
>> the SCX_CALL_OP_TASK family assumes the first argument is the task,
>> introduce a new SCX_CALL_OP_TASK_ANY macro without that restriction.
>> Also update __SCX_KF_TERMINAL to include SCX_KF_DISPATCH.
> 
> I'm not sure this is safe tho. ops.dispatch() can release the rq lock it's
> holding to migrate tasks across rq's, which means that other operations can
> nest inside - ie. there can be an irq which triggers ops.enqueue() while
> ops.dispatch() is in progress. That can in turn overwrite
> current->scx.kf_tasks[].

I thought that ops.dispatch() always holds an rq lock since there
is a lockdep_assert_rq_held(rq) check at the beginning of
balance_one(), which invokes the BPF scheduler's dispatch.
I guess I am missing an edge case?

> 
> I wonder whether a better approach would be tracking cgroup membership from
> BPF side. ops.init_task() tells you the initial cgroup it's joining and if

Currently, it is also not allowed to call scx_bpf_task_cgroup()
at ops.init_task() because the rq lock is not held at
ops.init_task(). The earliest possible moment to get a task's
cgroup ID is ops.enable().

> the task later moves to another cgroup, ops.cgroup_move() will be invoked.
> Would that work?

Checking cgroup ID at ops.enable() is not ideal because there
would be no cgroup ID changes between ops.enable() calls.
However, the additional overhead should be marginal. So tracking
cgroup ID at ops.enable() and ops.cgroup_move() will work.

Regards,
Changwoo Min





