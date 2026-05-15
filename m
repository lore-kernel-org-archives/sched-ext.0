Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827538758B
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839956; cv=none; b=rpQSxhVrJJ+JowP0HOH1b5jwbBlkrV8o8K77WXam9Waogg1Rz4lVv+PMuZRtgGYmaTVJ7hPYmxS8B5wmk8sknQ2JMAVkBb0NZGbXhM/7o4e6LlfnEBaeS/p3gbVp1uxEUiNVDNYGDv0Stv1nnufJwFbIGEvWz1nDoMGA3zXRt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839956; c=relaxed/simple;
	bh=OMHLxeqGbTlWeS7IvcYmDvMDR0Gv41of8yDbKwjgvMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWLqvNhXMB03GpEHMiWvnUiPCE2HQi5QSdbCI6FfNQYNTbir08hbWxhTBMOVpdM0fntGDalPmvrhbj+SbP7fJwvxsprUIh7dnFkAR+vtQUTdKSadNFqY4fUfBP9BhbuTaAIE8/zD1Nmu2ml86b/oDZdAjgb/xL2iZd8gxmRuCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Csqt5TLJ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Csqt5TLJ"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E8E1C26F47;
	Fri, 15 May 2026 12:12:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zwOz6aRYCWv0; Fri, 15 May 2026 12:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778839946; bh=OMHLxeqGbTlWeS7IvcYmDvMDR0Gv41of8yDbKwjgvMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Csqt5TLJ7hO8xeFIeowzZmwEMRJN0JAsIsolf/TZNCVYBhEZlED94mbnUn7OT/knC
	 ONfaWh9eYK6d3ILodDPu0FrA9S87CJdUE4xxbq+0w21gZOZE3LyffTcxPrYNLfQyAu
	 994p/zXEeCI8ecxnQMEsXdyKme98J22wePDRRjshU0YpGDJYVr9UkyBu25tGVCigni
	 QeqXiJyhsOk8UEyRik5PTeBXKNf+Fv3CznvyDW9b7WIMPDdxUpAqMhpCayAPLZEUKT
	 HVui5PszpF4a5Sq40OMEhJ3DiGH9iWtXsPrl8Cp/ud4P2spafImth+8vNJLH1hVKm8
	 mqmL1gaAQd7Nw==
Date: Fri, 15 May 2026 12:12:24 +0200
From: Samuele Mariotti <smariotti@disroot.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, void@manifault.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in
 ops_dequeue()
Message-ID: <agbxDkqPcq0P0Xjl@cachyos>
References: <20260513095329.4029345-1-smariotti@disroot.org>
 <agSKJbtmpRPLgYJW@gpd4>
 <agSpf9QRx4zqhZxx@cachyos>
 <agTYojgRwDH67QMC@slm.duckdns.org>
 <agV8-RlKEkiAbd-h@cachyos>
 <agYr1RbafGUevfOH@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agYr1RbafGUevfOH@gpd4>

Hello Andrea,

On 14/05/2026 22:08, Andrea Righi wrote:
...
>The code looks good to me, I'd elaborate more on the comment to make it clear
>that the retry loop is guaranteed to terminate (not a deadlock).
>
>How about this (or something along these lines)?
>
> /*
>  * A queued task must be in BPF scheduler's custody. If
>  * SCX_TASK_IN_CUSTODY is clear, finish_dispatch() on another
>  * CPU has already passed call_task_dequeue() (which clears the
>  * flag), but has not yet written SCX_OPSS_NONE. That final
>  * store does not require this rq's lock, so retrying with
>  * cpu_relax() is bounded: we'll observe NONE (or DISPATCHING,
>  * handled by the fallthrough) on a subsequent iteration.
>  */
>
>Thanks,
>-Andrea

Agreed, the comment covers all the relevant aspects and explains the if
condition clearly. I would go with it.


Thanks,
Samuele
