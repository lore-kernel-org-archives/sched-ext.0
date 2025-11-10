Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F4273810;
	Mon, 10 Nov 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790940; cv=none; b=HIRDse4I0ezGk6Ged73m+LF3N0AE9t7BzEhiVl0+7feVcAdhi401TCqyoSK3/0e6rpSM0jfoqaLyrjIlsIIl83tPSfBt02INisEXGBpdr25sML+TlSds2U+S04yXJ/WU58CoOKYOeW+vnbgMiqpblACqECnc39Ra10KAvxZezZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790940; c=relaxed/simple;
	bh=NBpmB+hnjguA3i8RznuHTjw2pYgzLf3scts8qyLJMp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXr/0XN3xwADwVzsTe/BIne/Uy/bNB0ViL14P2ZMuEaWOm1PbTKcJ+8QsfJ58b7TWNYgBMbBnZa0cEeu9Rxi3tTd0nLIRnizuiVyR5GSihIgr9+Hmblv/2fxoFxsLnTamENN8OUDwTjMMrB7JiPzc42gTGxFaFrJKfuCZItcsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXfklI48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXfklI48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814E9C4CEF5;
	Mon, 10 Nov 2025 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762790939;
	bh=NBpmB+hnjguA3i8RznuHTjw2pYgzLf3scts8qyLJMp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXfklI48xka0u1XmkPhtnSmR1XEDxmu+7Taf8hYhiJ7QRil2tCKIyZtMwR4tWraN3
	 iC05e2irCvyqiahWc0SzhpdYkG1SETpyhLw+q60RUZy5VV+Q7PLG+Q4rsRDAo2oyGJ
	 KeSg0nlhWIkLLZ9fxs5dKTQuyFDmVj3JN8b95snltBjqiiMKelwj5t7VG+vnwLODC7
	 aQzd+VztkmpRN+DrUKNCN728sml9i9uYoJdgAutBp+4FkppZYOlzVvYqoEpR/uYMk8
	 hn3hp614soPecuUjiOfaL/3M9y2u5P0oPbrcqdeYlvR1OV2L/+bydl6eEOrZlEJZrt
	 +pEnLKy21BO3A==
Date: Mon, 10 Nov 2025 06:08:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, Patrick Lu <patlu@meta.com>
Subject: Re: [PATCH 01/13] sched_ext: Don't set ddsp_dsq_id during select_cpu
 in bypass mode
Message-ID: <aRIOGt4S42czxMAT@slm.duckdns.org>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-2-tj@kernel.org>
 <aRGMzjXMkOsU-2le@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGMzjXMkOsU-2le@gpd4>

Hello,

On Mon, Nov 10, 2025 at 07:57:18AM +0100, Andrea Righi wrote:
> On Sun, Nov 09, 2025 at 08:31:00AM -1000, Tejun Heo wrote:
> > In the default CPU selection path used during bypass mode, select_task_rq_scx()
> > set p->scx.ddsp_dsq_id to SCX_DSQ_LOCAL to emulate direct dispatch. However,
> > do_enqueue_task() ignores ddsp_dsq_id in bypass mode and queues to the global
> > DSQ, leaving ddsp_dsq_id dangling. This triggers WARN_ON_ONCE() in
> > mark_direct_dispatch() if the task later gets direct dispatched.
> 
> The patch makes sense and I was actually testing something similar to fix
> https://github.com/sched-ext/scx/issues/2758.
> 
> However, in dispatch_enqueue() we're always clearing p->scx.ddsp_dsq_id
> (SCX_DSQ_INVALID), even when we're targeting the global DSQ due to bypass
> mode, so in this scenario we shouldn't see a stale ddsp_dsq_id. Am I
> missing something?

I think you're right. The bug fix part was a wrong assumption on my part.
Will update the description.

Thanks.

-- 
tejun
