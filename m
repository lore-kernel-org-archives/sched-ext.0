Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A312EBB8C
	for <sched-ext@lists.linux.dev>; Thu, 22 Jan 2026 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041876; cv=none; b=YxZFTIuJrakp4mCGj478K/XgrQYrN54496X3sWdNwyU4hIK2Rgn3PcAFub2ksK5FzlcyRa9SFtAMxMA3cKx1ErHj69a/s9OaImxvMjIKoUZ+5AtsnlxxVk69EFKrGS9eEnZ5ytBu5xb0T0EAVf3FDKMxTdVzgiiAFnQajS9mFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041876; c=relaxed/simple;
	bh=qMHqFnUYwMd2vT/iGzQWClXcOe8UXlgH+gyVa/Ri96A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4XFg1JhkZ0QUIJ89te2wLO9GhO7mwovSeqUHrb/LgbIXWvPyu5n752o3k+Ra2f7FaqOJIyaX94QRANLSn+bycZdnVCi39Lfj0aQRdk0t1tb2cwgbe4Xlbi29ZZ2PbYhe54Eurw/DmUwYa3i0/mES756fCvFIoB8F4E1c646wlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tAy5kb8Z; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tAy5kb8Z"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LNtlrM3806200
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 16:31:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=xo/tL6hh7C4DpTTAFeqb
	VPLUlSh+toQpdFyJ2q7Zf9M=; b=tAy5kb8Z4k+C3yI5LNVP3NgcbmmCYRsGjjTC
	565Php71u2eKRche7I2eH7Yo0ZZh33d7FuhS+vMtL/9C20MzBRgAppZry858Tvo9
	mKQFL7fgN4NGm67BSnp/SH+ua975mVjAsB4C52Jl53438F9AezXUjGeD3C8vQL71
	Y0xyCz5wlrLdVj6b4WdYuhv1w+6vQg6tJ6r0KqB5iBapi4UYpQBK1qqHyLeb04Wb
	ZVjCON9CDHBjcs5EskbAOLQfqWei2+h0k5kWdCSsIQeTNuzsZq6hW0DqGDI6MIoK
	EnYGhdkloBocYUjuPfwAejLfQE5jK3V91dBanxxjDuswfxlLDg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bu8wcg728-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 16:31:06 -0800 (PST)
Received: from twshared108366.16.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 00:31:05 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 7F39D3C93720; Wed, 21 Jan 2026 16:31:02 -0800 (PST)
Date: Wed, 21 Jan 2026 16:31:02 -0800
From: Daniel Hodges <hodgesd@meta.com>
To: Andrea Righi <arighi@nvidia.com>
CC: <tj@kernel.org>, <void@manifault.com>, <changwoo@igalia.com>,
        <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched_ext: Clear direct dispatch state on dequeue when
 dsq is NULL
Message-ID: <aXFukGjN0F7W3Hoa@fb.com>
References: <20260121155602.598130-1-hodgesd@meta.com>
 <aXFA4-b4WLPjxCME@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXFA4-b4WLPjxCME@gpd4>
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=MoFfKmae c=1 sm=1 tr=0 ts=69716fca cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=FxggWljr4EAZnMwrpr4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 41vyQKfCH2GnziUgiisUfYn8kUerGxYW
X-Proofpoint-GUID: 41vyQKfCH2GnziUgiisUfYn8kUerGxYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDAwMiBTYWx0ZWRfX7qENpNoxwKbv
 wO2YN0/GL/da8FSv5gAAtjFEa9JxnyWgjoIoVF80OtUM44aqszAzXOMNYEFCUOXS7sF6nmzQRrM
 mrG2q5h8AHPCVbbMVBTFyPQNvoKel8WG93w0btC4yCB7e8FBTIl3qRAyYXUCBc/xKeQ6cxrOJ3w
 AWTFEXVd/Jjn4AeAswQLqUJ8qTZjvidD09fYIaLHi7tMSSM5cVyJTwdv1ahGx2qDDMXiMxCsYDR
 aXZ64wcARM6FKPC/zaPAvysiqtR3Mbpd2I3cUwV2wnBvoh10kQbkNlc70F2AraZnILPt3Qwe6Da
 d3G04CtxbdxaJa9UHlYFtPXEVsdAaXH+caSSjQOpbBARet0bCk4ad9qSFerYV0DZ53py/POsdAM
 fqC6PU0F6K1ZnyVV6E3Lk72hVDqErD0ts1Wg+KboKGTC2t7VzJfHG0prvzVPnC9/QAKyoGFCBSL
 IXq0Uu83IVWkV748d9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01

On Wed, Jan 21, 2026 at 10:10:59PM +0100, Andrea Righi wrote:
> Hi Daniel,
> 
> On Wed, Jan 21, 2026 at 07:56:02AM -0800, Daniel Hodges wrote:
> > When a task is direct-dispatched from ops.select_cpu() or ops.enqueue(),
> > ddsp_dsq_id is set to indicate the target DSQ. If the task is dequeued
> > before dispatch_enqueue() completes (e.g., task killed or receives a
> > signal), dispatch_dequeue() is called with dsq == NULL.
> > 
> > In this case, the task is unlinked from ddsp_deferred_locals and
> > holding_cpu is cleared, but ddsp_dsq_id and ddsp_enq_flags are left
> > stale. On the next wakeup, when ops.select_cpu() calls
> > scx_bpf_dsq_insert(), mark_direct_dispatch() finds ddsp_dsq_id already
> > set and triggers:
> > 
> >   WARNING: CPU: 56 PID: 2323042 at kernel/sched/ext.c:2157
> >            scx_bpf_dsq_insert+0x16b/0x1d0
> > 
> > Fix this by clearing ddsp_dsq_id and ddsp_enq_flags in dispatch_dequeue()
> > when dsq is NULL, ensuring clean state for subsequent wakeups.
> 
> I've tried to fix this a while ago (same as this, right?
> https://github.com/sched-ext/scx/issues/2758), I remember that I applied
> exactly the same patch, but I was still able to trigger the warning.
> 
> IIRC there's also a race in ttwu_queue_wakelist tasks and
> sched_setscheduler() that can hit the stale ddsp_dsq_id (maybe other
> cases).

I figured there was probably some other paths that it could race.


> Long story short, the only thing that was working reliably for me was to
> clear ddsp_dsq_id and ddsp_enq_flags in select_task_rq_scx(), but I thought
> it was a bit too overkill and then I've never finished to investigate the
> real issue...
> 
> In conclusion, I think this is fixing some of these warnings that we see
> and it's probably good to apply it, but it's not fixing all of them.
> 
> Anyway, I'll do some tests with this patch and report back!
> 
> Thanks,
> -Andrea

Sounds good, I hit this running cosmos on a moderately loaded machine.
I'll see if I can get a reproducer made and do some more testing.
