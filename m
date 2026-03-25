Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB241DE3B7;
	Wed, 25 Mar 2026 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454144; cv=none; b=twoOr7ivoIl0u4Tnbj255Bzfo/085t9aOzRkNdY8r85AWf/dhiGTKgQ2kA6LxrzEBU7rDFcJ/jnCyetbiiZg6/9VGWKl/4jYStRoQZPIi4HkT2zZmcPKehkOXaRzrq73qaMhkqI03ksFS9s8N6O0cIQIvxvOhFfX3wQMO79g5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454144; c=relaxed/simple;
	bh=M3wYRsWacCiBj/FYOV9J+9Y03b07Wt57b04zgQ7Vgsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfIV72+UcX668Mshnb057bhzofMbq2udAobXk5MhjgYBdJw0Vpf4MeQ/lCDiqTd+W0+Ke1nKnQa+OCuUMwwuaL7yiX7R/c6wOTQT60SXpxMdeCyeAeWZvagJmgTiIgeQklxvbcz86fpbKGa8OEM5GhU02m4eIt5qGyAQbnYgzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnKvR/b2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnKvR/b2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3ADC4CEF7;
	Wed, 25 Mar 2026 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774454144;
	bh=M3wYRsWacCiBj/FYOV9J+9Y03b07Wt57b04zgQ7Vgsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnKvR/b2zW4ohTnQjvmriewU8YUedqgj6exdrk2mBtjxEg+Hh1cS8AAmYJJpJJnT7
	 LfSwcBhIsujpjqJcOJGoZX8yIZM2IUuA7OuzE7rjCKMwrNqc9jZ23jV8qKDpmznlA8
	 wfQWsAGu/SxyP5Uq6rOl5jBMfWnJy5g0i/bWJII+iW1Wg9yl7n5w+RLbind1eZABuJ
	 C2YXRCn013nkooOnmxqnRxWMqkVSPM5DxUiRFRnBs/PmOXcVDknCnZgSdFu+hmcq8x
	 GRs3wsZZ84TRwY0a3vCVk4RIk4dMgMzA8Q6JKJOLfhytiV7J2rzedfTUDbpCQKylKc
	 mBTqhBmNTONrg==
Date: Wed, 25 Mar 2026 05:55:43 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	arighi@nvidia.com
Subject: Re: [DISCUSSION] SCX_OPS_ALWAYS_ENQ_IMMED semantics clarification
Message-ID: <acQFf7iD66CpZGB-@slm.duckdns.org>
References: <20260325073920.758426-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325073920.758426-1-suzhidao@xiaomi.com>

Hello,

On Wed, Mar 25, 2026 at 03:39:20PM +0800, zhidao su wrote:
> 1. Is this behavior intentional? Should "all local DSQ enqueues" in the 
>    flag documentation be understood as "all BPF-path local DSQ enqueues"?

Yes.

> 2. Should the flag documentation be updated to clarify this exception?

Maybe? What the documentation is trying to say is that if the ALWAYS flag is
set it'd behave as if all dsq_insert / dsq_move calls that the BPF scheduler
makes have IMMED set, which is what it does.

Thanks.

-- 
tejun
