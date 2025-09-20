Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8C1E89C;
	Sat, 20 Sep 2025 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758334559; cv=none; b=eVnYVebkM9N/qpuJFyFKlaEZtya/JlKPNA4wJsSq2r/tMSYNU7p/n107znjeVnbX80jUPIrx+gA54VJ7mHIJQrAF82wa8v8iFvDyFMZtp5V67fSLlWjHQs+vOd3DG69298IOkrtNWHEj4b7JwIeIJ2BgTZ/3GKroa0B2sc1GTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758334559; c=relaxed/simple;
	bh=Ohk+ZiFgbv6FHyKJDrwAcKmT0uIB0mpqWbgyH34a96M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JisBOydeSCKKqaYxMknIRIP9dgD+ppthbt6FwznOEVRTmvDjoPZatznXKhprD4amTrzJqlHE2z6fE5SNW7AYcBw8OTHZztC1xxjVofoVyGjF+D713M62XhV2rXXIAAPSS/o5QOuUjiwyIJFku71cNrKrhXGUId3xA19dktWH+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aSRTVQt6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aSRTVQt6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7H6Vsrc0BKaQc5qCnmMcwHPVadXmgkUPAO37Crtf7fo=; b=aSRTVQt6s0a5T9A8J0d0pbTm/s
	r1yLbYf6SUHwDg9wGLxeTwx6WGxIWl2dOhWj5bPIvUbyP37AUSuk7tmRVmStc3OGNIxftup2Cg2DD
	+0HNkgEr3C9MZ620UtGRGQqfXDPlKovk1qyFNTUie7gxyh5KK4d9QSfWg9EVWiAc1/r16qoH0gvYO
	yLlZTgKbkMpjn60CVnrhNjTWgy1NuLV0t1M2QAAEJQaPpjwP7wLLdSnrHhs/Mh6qNFP/zwLgBf6kf
	maxrMFlwnrvTu8b0lVbezEtxzpSatnQ924hgQhIdoaIXu5FdlF288jCSeueUv6A7ZCrb3jE9LPycC
	Fz0YnpxQ==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uzn8X-00EK40-Vs; Sat, 20 Sep 2025 04:15:42 +0200
Message-ID: <edd77a64-6f7b-45cd-b2e9-36b67a7ca44e@igalia.com>
Date: Sat, 20 Sep 2025 11:15:35 +0900
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
 <2ef92808-42c9-4f8b-9d58-11e5d2c89fc3@igalia.com>
 <aMpAaLZ_UF6qwTGM@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <aMpAaLZ_UF6qwTGM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Thanks for the clarification.

On 9/17/25 14:00, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 17, 2025 at 11:12:18AM +0900, Changwoo Min wrote:
>>> I'm not sure this is safe tho. ops.dispatch() can release the rq lock it's
>>> holding to migrate tasks across rq's, which means that other operations can
>>> nest inside - ie. there can be an irq which triggers ops.enqueue() while
>>> ops.dispatch() is in progress. That can in turn overwrite
>>> current->scx.kf_tasks[].
>>
>> I thought that ops.dispatch() always holds an rq lock since there
>> is a lockdep_assert_rq_held(rq) check at the beginning of
>> balance_one(), which invokes the BPF scheduler's dispatch.
>> I guess I am missing an edge case?
> 
> ops.dispatch() is always called and returns with rq locked; however, it
> sometimes needs to migrate tasks across rq boundaries and thus can
> temporarily release the rq lock it was called with. Please take a look at
> dispatch_to_local_dsq() which is called from balance_one() ->
> flush_dispatch_buf() -> finish_dispatch().

You are right. I overlooked that path.

>>> I wonder whether a better approach would be tracking cgroup membership from
>>> BPF side. ops.init_task() tells you the initial cgroup it's joining and if
>>
>> Currently, it is also not allowed to call scx_bpf_task_cgroup()
>> at ops.init_task() because the rq lock is not held at
>> ops.init_task(). The earliest possible moment to get a task's
>> cgroup ID is ops.enable().
> 
> ops.init_task() is called with scx_init_task_args, which contains .cgroup
> which points to the CPU controller cgroup the task belongs to.

Yeah, that's better than relying on ops.enable().

Regards,
Changwoo Min

