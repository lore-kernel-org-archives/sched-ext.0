Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C64FB9CD;
	Thu, 15 Oct 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082278; cv=none; b=qeLIm2v34HgCxNBbari8kEd/h/G/5RpfdBgAQTmH+ubXiGZPhoEbHT8tsJ5GcvpqyJzqCA2tLukl2PNXrlAfioXQLlkq5k10mKghy95GVEQfHoe7dvRuFDbyZggzLk73Ol82hixU4tGTJ91ZFiPN25dsqvyWw41Jy4kBXUDgceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082278; c=relaxed/simple;
	bh=1Mx7nzrijQCwZKfJgILXQUyfGPCla31BYser62ENaiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avXm5sZy65sEGyyHRXIc+VH7qxK98iR5bEi102kM8zLZep62XMOt7qUAT1V4/jd+guwRq6jStIpByNw9JJfp+7x4B8G/4fYh/ytV9Sp1MuGUSE7vHAAKG/HDwHideHNK6Q/GZMCn3wQgvwHF4TFkdJAJOTAn3RyMZerqqIXt3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHEG4nOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHEG4nOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5CB1F000C4;
	Thu, 15 Oct 2026 16:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792082268;
	bh=TOjJgN7sY8AKjHZra2ug3Cwa5Wm0K8+baa3q8Q0b718=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AHEG4nOxsEFUgzWLG9F4v+wHcBKATOgfjNMYATywmuf9im/8orZaPvkHapL6L36kH
	 tCyPq/Kr8wMO0fjPOUqMlUvuWs32Kah4K4IDBT4KOEMSZHxILuWM8jRTgcMA9xyEUF
	 R/CAKg8N3BV3u/swt2ijC00xtgpwd32mAT8v4OJlUAlTGekXnYSgS5+O6QPc11+vZG
	 HCFcYH/xD2iu+0KAXReC78WUECY/5Ugh1caROp3RbtiEZATu104eyR0H+wr4Vl9cbK
	 qPQij3hBeRXm5S/SbI0quAjumxq2l7xuDM7yNktBEp4DtmNn+urH9i7WB/32vTiN3A
	 3khu8PsWVxfjw==
Date: Thu, 15 Oct 2026 06:37:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, trilok.soni@oss.qualcomm.com,
	aiqun.yu@oss.qualcomm.com, abhijeet.dharmapurikar@oss.qualcomm.com
Subject: Re: [RESEND RFC] sched_ext: Support RT task within sched_ext
Message-ID: <atEBWwXSt4D8befY@slm.duckdns.org>
References: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>

Hello, Tengfei.

On Thu, Oct 15, 2026 at 08:47:12PM +0800, Tengfei Fan wrote:
> Possible options
> ----------------
> 
> One option is to let sched_ext schedule some explicitly selected RT
> threads together with SCX tasks.
> 
> This could let one scheduler choose CPUs for both selected RT
> threads and SCX tasks.
> 
> For example, if other cpu is idle, or running a low priority scx task,
> or running a low load scx task, an RT task could use that CPU instead
> of a CPU running an important high load SCX task. This could reduce CPU
> contention for the frame important KPI and help balance RT and SCX tasks
> across CPUs.
> 
> Such placement should remain a preference rather than a fixed
> rule. It must respect the RT task's priority, timing needs, and
> allowed CPU mask. The other CPU must also have enough capacity.
> 
> It could also allow RT and SCX tasks to use the same utilization
> model. We would like to study whether this can make the load
> signal more stable and reduce late CPU frequency changes.
> 
> Another option is to keep all RT tasks in the native RT
> class, but provide enough information for the two schedulers
> to better coordinate CPU placement. However, this would also require
> placement and load synchronization between the RT scheduling class
> and the sched_ext class.
> 
> After the LPC discussion, we'd like to explore option 1 and use
> BPF-only hooks to achieve current needed RT tasks within scx class.
> 
> One option is to have all RT tasks with a priority lower than the SCX
>  helper thread go into sched_ext.
> 
> Migration thread, sched-ext enable/disable threads and IRQ threads need
> to remain outside sched_ext. With this option, we will need to verify
> more common scenarios. We can explore the first option first.

Isn't an obvious option to just make them non-RT? The load tracking aside,
the fundamental problem seems like you don't want these threads to be always
prioritized over some of the OTHER class tasks, which definitionally means
that they shouldn't be RT, no?

Thanks.

-- 
tejun
