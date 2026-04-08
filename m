Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266F35972
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623639; cv=none; b=EPNFKwYH7soO8oEKY9erQ1iRDm+Upt4huuAJo9Q9TwVFlCgqbfF/6U+z2GnKOyioSBhPPQ4E6ZS8Pd7xo+4B6Z6CfNh+TrgrpPaiZ3lD3FCSB1qKQsZpht/uADiiuK5YYUGSxf1YIiOjYa6UJXMHbFLNjMyFyHh6nQVeLaya1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623639; c=relaxed/simple;
	bh=ij/FQrCWmW8vdteY7JxNZK+TpeUEbt6s67bGzONHR50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4+Bt/XDMnJnstpVHXPsFGInb5lyM/hDT2i4xT7jNmRgcjUzTRQbPZNB2nQwzwEPQxCjCm6Zm4GQm4ytfPReRbNDhWuK/dFvz/CgaRViDM22l7gOefbog0PosvRJf7TmxlOUoLPTNMk4B4aPcrCsAy6yK0oJadTMPKRQOI2fZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfXETUk5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfXETUk5"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82c70e4654eso2644772b3a.2
        for <sched-ext@lists.linux.dev>; Tue, 07 Apr 2026 21:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775623638; x=1776228438; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGr+zXkBV1n2fo6k5RDlLaxck90xEF8/J3gjY6ypPAA=;
        b=HfXETUk5K6u2kEmoZ1ie+BUupsAZO+HLLo8+ea2plUC/5N1JGYrtotwzWH9HmNBpca
         QL7+SYIg+gR3+YHcOVwsRBITpH9OFarKlW9LfHyVt+WcYLCiEF/FLGUGNOGgich+z4gn
         vu9GpmexwcmFyQbN5gPRb5BTn+byWClyf8yL4ou9iJZ/QiMRqBkyBmyUij43HODGgqFa
         sLUjkot8vGwGiIXu6eKxH1ljE6xRPyrk6bma6qMjhjSA1Rhhf5bpHc6fXs+PXCiQEpK/
         n03Yc81uh2m4A/VSqnEJMZ8Bv3Ida6jBvh/vwfPG+cpXiP6oHDoXOL1CmD2U75f+t2C4
         /8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775623638; x=1776228438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGr+zXkBV1n2fo6k5RDlLaxck90xEF8/J3gjY6ypPAA=;
        b=EWQka7iRIsOJpFmZeSX6ahfGYE2SCkZ3CdR9REVln3su5ZNvF3QKwlF39L/Xb59mWY
         M35yulbyW5Bmn/BcMnw6cVwD4uBq1pJd8hsF9LTg3vx3N9Gb14UNObcM8WiV9RVvrVJ7
         YD+p0XQmFQZRfObdm5rc4qbB+BQZcGY+KpZVmpj8kA7EKIE7PKyeuOBEIFf02m75yE6m
         hQyNrlX7NZiuinq7ertWDYmp+UAcUajcfUxz8cw66XXpSXxtFuzHJ65t+3S5vIEklDxJ
         MdYc8Td+Zu9moDhzMyhg+JN7RlDbiyrg74IREFiRvUl6TJuAhZ3rDJhCCI7wg8PWKacZ
         5PFg==
X-Gm-Message-State: AOJu0YyY0NK0VKpk2laQHAi3orRZ3ntZaE1RznYXr6lrNYmEnfNalG/J
	pPpMYeFEtw4eernXmyNUdBdqDsvwazkllFIK28SM9RySyRX9LZvBM9iy
X-Gm-Gg: AeBDietN3n1REATdcyiMTH8ubzEu7RVum1uxO2kNbI+kmxZpqZHIMREjj0jFjtE7DDp
	FNvx5ZmqtTmy/UonJsYZ5RU3n/zo/FP1zEqdIWvZym7CL90kcYiGXnh71pRlavy7h5KItmAHttx
	z1yz9mOilXNqCfx7cgTBF2Sn/2OsRT6NNKEocTpicayLM2S5N+8QiJJ1zzBOUJwVdIfdFJ9StXo
	MzWEWbiZ003Npw6haw0jnZVMoy69OZqTr6SAPHaqa7ktesHLRTlIPtAVh+sAS6mQwsQaaSoH2br
	ymZGN46uI3rqYZ/9WuSpNv7LRaKvIbsmh3wabPc3jR7o93mHff2s8kBkTKj9gZ6MpbNWnFlbKbn
	cMamQDqEIcH+a/uzV1xk3KOV0t7uaBJyc8ZRQdPQnsDo9sQWz6/90Vv4TFTYMG6/57DaUtLefyQ
	i5K1XzTw1mepOM2tWCzSIsIhgwCNw3
X-Received: by 2002:a05:6a00:1da1:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-82d0da928c1mr18157746b3a.18.1775623637457;
        Tue, 07 Apr 2026 21:47:17 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:4c23:8546:f68d:c612])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm20106495b3a.38.2026.04.07.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 21:47:17 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:47:10 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: fangqiurong@kylinos.cn
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org, 
	arighi@nvidia.com, mingo@redhat.com, peterz@infradead.org, jserv@ccns.ncku.edu.tw, 
	chia7712@gmail.com
Subject: Re: [PATCH] sched_ext: Remove dead code in scx_set_task_state
 default case
Message-ID: <g34iyvtsaols5xj7jw4uxw43uhvionnlrv27njrvcezlibrmis@5sdswgdh5ktb>
References: <20260408032025.3042093-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408032025.3042093-1-fangqiurong@kylinos.cn>

Hi fangqiurong,

On Wed, Apr 08, 2026 at 11:20:25AM +0800, fangqiurong@kylinos.cn wrote:
> From: fangqiurong <fangqiurong@kylinos.cn>
> 
> The 'warn = true' assignment before 'return' in the default case is
> dead code - WARN_ONCE is never reached when returning early. Remove it.
> 
> Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
> ---
>  kernel/sched/ext.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index e8384b5f1b0f..4aaa7bf1faa6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2934,7 +2934,6 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
>  		warn = prev_state != SCX_TASK_READY;
>  		break;
>  	default:
> -		warn = true;
>  		return;
>  	}
>  
> -- 
> 2.25.1
> 

Thanks for spotting this, but it's already fixed in b905ee77d5f5:

 https://lore.kernel.org/all/20260402170025.1387202-1-smariotti@disroot.org/

You can probably use Tejun's branch for future contribution:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git

-- 
Thanks,
Cheng-Yang
