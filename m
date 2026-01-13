Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AA3019DA
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283843; cv=none; b=RjwftTApmPV/R8WLa4fmkmjuxXdyEIf9f5iG+8r6j5e47fEQPXr6xobK7H0Yc/nUoYOrzZJcHh8zv+v6DclUh02rpWb/qng/u7mkakN8kc+ZoR3iDoLS8xhWk7Qi6DKQ6/2lS1DoUctxyNTRhemwC1AoOQqUAM6BSVSSUT2alN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283843; c=relaxed/simple;
	bh=94F3fxQkWAaHhEIw8ITE51K3aT6XljaAQSCYyC3oTA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCkrrmk09GEl4QdkDxpNEEW8jjFpsuuinsP34IiLn47fccFxc2HsXRBUIm5lecmPuDRxCwa7GJZJwInOIqYgxgKHlUSvI+/ez4+LH8LgAy2dwkJjSkmbGXPatbzKzvc+AWVaRizJ9Idx5PtBXLFZFi86W+gSUq3NsCX46hlG4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MD2TCqpJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MD2TCqpJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kctzGz0vAYun69bB0W/MjraZFXaGMsDtLU3JD4gTcpI=; b=MD2TCqpJKRjJAVbGPRWbAtsSR6
	qrwVqlCaEuOURc4OibDyi7ZltitmPAF5SWEBpkXkUefBFADwNK73rP0XECOqFAVaUdGUCI9XVwCDQ
	afRL9J9hXtOMvoqJobztTcuOSF2abYwnr27MbB8CZRRl5YJGLy/zFhOwC4Y7riKX7sxsAdpByT8IW
	rOnDFFbdbZQ4MmUNvoJxlLRXv22qZncHAJyV4B1UOADrqaRxH015je01MjriA1R+bsXhR1pf8rITw
	38Q3DEY0ZuRNfqX2qmHM8hUN20fxTMrmi3EAZx0lmA9zACR7I592GWqQq5SNSeD4bf8g5HCKELQLN
	e5C3BO4w==;
Received: from [58.29.143.236] (helo=[192.168.1.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vfXP4-004hYX-34; Tue, 13 Jan 2026 06:57:18 +0100
Message-ID: <77b165ff-0cc4-44bd-b3ef-9221f8238f20@igalia.com>
Date: Tue, 13 Jan 2026 14:57:13 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tools/sched_ext: Add example C schedulers
To: Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev
Cc: arighi@nvidia.com, tj@kernel.org, void@manifault.com
References: <20260112214131.50236-1-emil@etsalapatis.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko, en-HK
In-Reply-To: <20260112214131.50236-1-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,

On 1/13/26 6:41 AM, Emil Tsalapatis wrote:
> Add to the tree several C sched-ext schedulers developed and maintained
> out-of-tree by the sched-ext project over the years. These schedulers
> demonstrate sched-ext's feature set and provide a starting point for
> scheduler development. Place the schedulers together with the existing
> examples in tools/sched_ext.

In general, I am okay to include more examples of C schedulers in the
kernel tree. However, I am doubtful whether it is worth including the
nest scheduler, as it has been barely maintained in recent times.

Regards,
Changwoo Min

> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> Emil Tsalapatis (4):
>    tools/sched_ext: add scx_nest scheduler
>    tools/sched_ext: add scx_userland scheduler
>    tools/sched_ext: add scx_pair scheduler
>    tools/sched_ext: add arena based scheduler
> 
>   tools/sched_ext/Makefile               |   2 +-
>   tools/sched_ext/scx_nest.bpf.c         | 652 +++++++++++++++++++++++
>   tools/sched_ext/scx_nest.c             | 240 +++++++++
>   tools/sched_ext/scx_nest.h             |  18 +
>   tools/sched_ext/scx_nest_stats_table.h |  20 +
>   tools/sched_ext/scx_pair.bpf.c         | 610 +++++++++++++++++++++
>   tools/sched_ext/scx_pair.c             | 180 +++++++
>   tools/sched_ext/scx_pair.h             |   9 +
>   tools/sched_ext/scx_sdt.bpf.c          | 710 +++++++++++++++++++++++++
>   tools/sched_ext/scx_sdt.c              | 101 ++++
>   tools/sched_ext/scx_sdt.h              | 113 ++++
>   tools/sched_ext/scx_userland.bpf.c     | 344 ++++++++++++
>   tools/sched_ext/scx_userland.c         | 437 +++++++++++++++
>   tools/sched_ext/scx_userland.h         |  17 +
>   14 files changed, 3452 insertions(+), 1 deletion(-)
>   create mode 100644 tools/sched_ext/scx_nest.bpf.c
>   create mode 100644 tools/sched_ext/scx_nest.c
>   create mode 100644 tools/sched_ext/scx_nest.h
>   create mode 100644 tools/sched_ext/scx_nest_stats_table.h
>   create mode 100644 tools/sched_ext/scx_pair.bpf.c
>   create mode 100644 tools/sched_ext/scx_pair.c
>   create mode 100644 tools/sched_ext/scx_pair.h
>   create mode 100644 tools/sched_ext/scx_sdt.bpf.c
>   create mode 100644 tools/sched_ext/scx_sdt.c
>   create mode 100644 tools/sched_ext/scx_sdt.h
>   create mode 100644 tools/sched_ext/scx_userland.bpf.c
>   create mode 100644 tools/sched_ext/scx_userland.c
>   create mode 100644 tools/sched_ext/scx_userland.h
> 

