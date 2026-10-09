Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0037F73A;
	Fri,  9 Oct 2026 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585652; cv=none; b=GMUdjb+StL8HxQwzaMTci4PKaXTc/b29stWUH6n0iMMpD67APTHVUx2v4FR3uGylyGxkr7Xat1T0ny37doScwVJT0e9COmhQStndgRE8gN6Qi4BhSpOFc2z8NvRnInFfM1H4nPI6WGc5lY2HyRw3q+b3qSXJt1eT1Ai202Tp/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585652; c=relaxed/simple;
	bh=ebSxbaeX9VtAmy3NlLk3TDWspMGNQU4XXf2W3m/QLHw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=F94qHPUQEmQAG5HCk0A/bOzmfhME45WbDx2Qj6xQSZ5nHo7aD3CsChI/w4hSQVZcIeA2zwcOEGl6a+TzMk2O7Bq2EHarFCs0usAX4CIeY5CzJsBiIEt8wFgnfLrVcl7u40snjnETPm/+zzG5KtafcptkYn+918KQ0g7UQV/MtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6MQv7QN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6MQv7QN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F841F000FF;
	Fri,  9 Oct 2026 22:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791585651;
	bh=YVvBqpBdV0HzuwYZJeTRNltiNfByvN0GZqY1/eYvd00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c6MQv7QNYyd7r97Va0MfKERwH8lsMpblA1JDcFlVYnMEFyLEzVXimr9D1qhPPuxWZ
	 LVreOkydBlRJUOJrql5M1+PyS4rRY/MHO5AHgpy7oVtpkp86sF/29gzpzCBxVl0Ean
	 OunwGOf+C6n+8rAgfMLClBLV0WPrXSyyjsd3ekHvcmYiWED4LhAOkGfKfP5bjXrKW5
	 9cV8swoE4eR3e8YcXiKsric+eWk0li9ABWGhclATfFCw5h6sWgkoSMIGpfcOTqBGHf
	 jK3tQ0s0fLds1oGaELOJ5aSTmFqablmD+/qxbKfeMUQLKu7usE0avPDAdD/pNqJlB0
	 5QQZLp026rkCA==
Date: Fri, 09 Oct 2026 12:40:50 -1000
Message-ID: <fce83a32347037f85ea4ba13e6e75765@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix use-after-free of a destroyed user DSQ by a deferred reenqueue
In-Reply-To: <sashiko-outbox-166126@kernel.org>
References: <20261009220001.196762128-1-tj@kernel.org> <sashiko-outbox-166126@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Fri, Oct 09, 2026 at 10:09:59PM +0000, sashiko-bot@kernel.org wrote:
> Does this code compile when CONFIG_SCHED_CLASS_EXT is enabled? Looking at struct
> scx_dispatch_q defined in include/linux/sched/ext.h, it appears the correct
> member name is pcpu_user, not pcpu. Using dsq->pcpu might result in an
> unconditional build failure.

The patch is against sched_ext/for-7.3-fixes, where the member is still
pcpu. 92344fad5b54 ("sched_ext: Skip per-CPU data allocation for built-in
DSQs") renamed it to pcpu_user in for-7.4. The merge into for-7.4 will
carry the rename.

Thanks.

-- 
tejun
