Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47941D21A
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289346; cv=none; b=NXAPeA8CqkFPzCmZfN4GFSJ2DdRK0DFYuY454d48aGIM6oG1lllIsHe1rUt3LpbXKHEK9hCv17/vuAreyxWyc6pnAXUM5QQnliwX+VGfQ8Xqr43RG32MCj/1PxlBOdffpzTOi38//azJ8fWUpa2WCplgwB9O07G5OlU0+njMz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289346; c=relaxed/simple;
	bh=vtr6W1O31FpaX/pzPdDit5sOxv1DO5xUcNtn4hmhJaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKqJ1rkx4Kl3//NcJV5Z4MEqCJyL4E1WYX3xSFVK5YMi7fyNyAcJp8fppFu9k5b8RYIAQ3yohbUQO44fH+k+ei39kIcN/3U2K/6soyvjD9jo0//3GMLxxuFhMu3o8CtnzGuu1sNOdEE06w3mV3MDYsPz3L6bb16XQx8p3I0D2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 435f209cb86811f19a56ed5b684f684d-20260925
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c6beb6ea-48e1-4be4-b826-17633d0beb8b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:54f32270c7c6fe69605ccc699f2c9a9a,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 435f209cb86811f19a56ed5b684f684d-20260925
X-User: liwanwu@kylinos.cn
Received: from [10.42.12.206] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2006305272; Fri, 25 Sep 2026 06:35:37 +0800
Message-ID: <e29045bd-6043-4f1d-baea-7616e7090c39@kylinos.cn>
Date: Fri, 25 Sep 2026 06:35:34 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tools/sched_ext: Fix three example scheduler bugs
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924143659.268595-1-liwanwu@kylinos.cn>
 <9c8dd70b66bba55c87376f227d986945@kernel.org>
Content-Language: en-US
From: liwanwu <liwanwu@kylinos.cn>
In-Reply-To: <9c8dd70b66bba55c87376f227d986945@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tejun,

Thank you for the careful review and for catching this. It was a
serious mistake on my part, and I sincerely apologize -- I should have
tested the fixes before sending them out.

I will reproduce each bug, verify that the fix actually resolves it,
rework 3/3 properly, and send a corrected series when it is ready.

Again, my apologies for the wasted round-trip.

Wanwu

在 2026/9/25 00:17, Tejun Heo 写道:
> Hello, Wanwu.
> 
> On Thu, Sep 24, 2026 at 10:36:56PM +0800, Wanwu Li wrote:
>>   - try_dispatch() trusts a pid popped from a cgroup's FIFO.  If the
>>     task migrated to another cgroup between enqueue and dispatch, it is
>>     dispatched under the old cgroup's context, violating the core
>>     "paired CPUs only run tasks from the same cgroup" invariant.
> 
> 3/3 calls scx_bpf_task_cgroup() on a task from bpf_task_from_pid(). The
> kfunc only accepts the tasks passed to the current op, so the scheduler
> is disabled on its first dispatch:
> 
>    sched_ext: BPF scheduler "pair" enabled
>    sched_ext: BPF scheduler "pair" disabled (runtime error)
>    sched_ext: pair: called on a task not being operated on
>       scx_bpf_task_cgroup+0x15b/0x160
>       bpf__sched_ext_ops_dispatch+0x47/0xa3
> 
> This means the patches were posted without being run at all. That's not
> acceptable. Please reproduce each bug and verify that the fix resolves it
> before posting.
> 
> Thanks.
> 
