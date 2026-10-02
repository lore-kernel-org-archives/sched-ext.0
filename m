Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1030569F;
	Fri,  2 Oct 2026 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980409; cv=none; b=kr62w9i3UuSJg/KU5MqH6/wHHG7DY0yyaWIYhf/eKQRjcP1SMAZgyJaG/AA8paX3EudrXiOtgjeIHuR3VMEKTOJkZ1p4Jz96roQdlBWdAhwLjcaCYSAcR9vs3MY+EMN6mH3fW/ZFCIEIov3V9pVcr3ahmwjG7pl3EH/OMKpvPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980409; c=relaxed/simple;
	bh=FIc7Uf6agUiqU1IgvD+7663OoEpVncOKLxiHF7T1AOg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=oRdh3NvhbXisZn+o0wdpMe6mjVkEdkW/nsDqtyEh9fvGlN7Dti5bUSsgZydOLPus9Kw/d7WPt1zKapgTyk9bF95L3uW442T1Gr82GuhyO8Pqp2iJAQDAFBQ+Y7hLbbZGhGBXvFByPjIBedTgjptjieahic5X5RFnQMigdHIg218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YphFLVyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YphFLVyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5080C1F000FF;
	Fri,  2 Oct 2026 22:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790980408;
	bh=rfidq5xdZHWNaS7xidcUdR3E+fOkf4Zx3CUAE9Bn+W4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YphFLVyzxhKmlMfnupFGvSgLuUYFODcvPrFYhj1b8mzHpWO6o9tUOhOkID06WdISG
	 B3ryXbo3obaR9sIYEZlgsGV6paz00ORt8e5SGwsH/2tmn5ZMo5Z0Hd9L114UObQqeS
	 5aOqcZZ/RCUUMQhpr2NWBqKNBkoBCuJ3Ff6bAG6cl7n36D96HJI/UcKGfw5nxkvK6N
	 8qqItMwBs+a72lEcFo87nTBUJ6do5PtojtEyouUmew0WsvM56K7yrk1HcVtAR7aHvq
	 kmyNXkYndaCcKAiZ93gCgnj06L031xqRbjl13jpZPWhUhuTU6B7mQD6AIyUcHUAIpY
	 VK/S2Qn9hxfJg==
Date: Fri, 02 Oct 2026 12:33:27 -1000
Message-ID: <86a16fc6ea0a57cea7459ac2ebfdfc1b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Generate qseq from a
 per-task counter
In-Reply-To: <20261002205242.3820674-1-jpiecuch@google.com>
References: <20261002205242.3820674-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Kuba.

On Fri, Oct 02, 2026 at 08:52:41PM +0000, Kuba Piecuch wrote:
> +	do {
> +		p->scx.ops_qseq++;
> +		qseq = (unsigned long)p->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT;
> +	} while (unlikely(!qseq));

Maybe wrap the counter where the QSEQ field wraps instead of looping?

	p->scx.ops_qseq = ((p->scx.ops_qseq + 1) &
			   (SCX_OPSS_QSEQ_MASK >> SCX_OPSS_QSEQ_SHIFT)) ?: 1;
	qseq = (unsigned long)p->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT;

On 32bit, the shift drops the top two bits of the counter, so the mask is
what keeps the counter from reaching a value that shifts to 0.

Thanks.

-- 
tejun
