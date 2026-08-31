Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D843F4AB;
	Mon, 31 Aug 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192794; cv=none; b=ow+xOuyoHP2Gmkhddd2WpKxr2VNvWiaDTPjSSP61soA9X5039ucYDeLClKXLgmjRhV9jE46tf9k+OcNqJPv2WdaMmKPQPyrnhO9W+ej35tZ3jwn6pyz1OfzHptyDHsQ5h9WoLLsQ55M3IaU5NglX9qvJ9BxY6CxRfcjdw2W1Ato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192794; c=relaxed/simple;
	bh=pnuV4DofHNIVQkX4uArFDlfXayHHgeEO1RGmvH8c54w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGP6bfhvwVi0IDr5IsvhMTeE3DUoVzU894oJpSTo8MKr75APbOuiZYGYx6wZeUUiOdd95KcjexvA1m5u4F6diMJea52OzXTfkNLZ1s7qdn9blqm6IClAXpZf2r+Sqckqn1Lt2WxEJemwV8dPdyOed4BSa6TUWDjcekSedYrp0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6mpCpqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6mpCpqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE061F000E9;
	Mon, 31 Aug 2026 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788192792;
	bh=vbBLSVpBzAajdVu36N3ZXXP0OVMGwY1r8j9t8qEMS+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h6mpCpqSuPA8V0S7E+SU22uAoe15aCYfo8gtMQifDmwddKnK7yS/dzTRFZPf4HoP1
	 53B4tgsMg02Q/xFw+IhyTaf6AlQSUVIZXreZUaIZdo9Qipne+TnR4esqUWuT0N2kAo
	 iFzdTreqQdCVDUUgDHDKTQrxhhj7iJLtubvKI4a3znSbBdMzOF0fy8D80AM40LTFtJ
	 7fgGf/IPu12YWbA/Trt16MyB9cqNU0JgdJgGMdrRnUUPOylVGrzcJTP5rZiGz3+6jf
	 VBnk86dGAtXMYC1R7r91apWj5g8lS4DCR6cSBTCporuqWogdzyOvCmuLDiRQtfocS9
	 hHkhqhuU5TIDw==
Date: Mon, 31 Aug 2026 06:13:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Skip per-CPU data allocation for built-in DSQs
Message-ID: <apWoF6Czswh-sO6V@slm.duckdns.org>
References: <20260827082329.3368255-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827082329.3368255-1-fangqiurong@kylinos.cn>

Hello,

On Thu, Aug 27, 2026 at 04:23:29PM +0800, Qiurong Fang wrote:
> From: fangqiurong <fangqiurong@kylinos.cn>
> 
> Deferred reenqueue tracking is only supported for user DSQs:
> schedule_dsq_reenq() serves the local DSQ through
> sch->pcpu->deferred_reenq_local and rejects all other built-in DSQ
> ids. Every built-in DSQ still carries nr_cpu_ids * sizeof(struct
> scx_dsq_pcpu) bytes of dead per-CPU memory.
> 
> Skip the allocation for built-in DSQ ids.

Let's rename it to dsq->pcpu_user while at it.

Thanks.

-- 
tejun
