Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6332FBE1F
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749382; cv=none; b=fi9jGQ6V2lrANuS14PAnk87cQ58HNYZB/AenGflf+ydVBCBZrx6VOJl8wu2EXoe3LfyvTAJkAFmKY2iG5gZt95BDqI0d6l4M++g2UzvqR+C75uywnU0ZK8qCcRsmujX/9kVddX5moUeHQ59vBFBRlXz1jrhYY12lxGAxIc8ySWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749382; c=relaxed/simple;
	bh=malqePsjYETlp6YRyNOGcOnY/0Qdf0rdTDZd6rzljMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+so5MS+S1+ouDzoiX8FviOe16bQF3lCU7nCOT/osXaE6lSGM0iNhmYQHQstoLWe0z2CF0ZUBzA8WcuDXtRulYEahiO/biQbue4PRGbbGdQ3qtLR9FKElQSyFBjadyL+ToOSONZ0RY0dtPM2NpkF+JPdT0y7oQshGlhBoopdlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=v0Hofomr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="v0Hofomr"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1438382f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783749380; x=1784354180; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JXWYlcHV8kyBocpQgRM3YOKQ4YhOMcY53dOQDtkUlDg=;
        b=v0Hofomr4evkpscfUzGjzMTbqXsC+R9A8ews/dH2gosA6+66gPzCfLwB8lDd4ZF8Pa
         3ihxSWyLB10vqD+gCXHPpCGXoqwNfv4hFHLUm6rzbsbKXbtF3IKAtQIC9OL4pTl7E/P+
         Y8AX5QJvhy+9QtccMdG/wIIHwvEJPj/bMA//Bxyd2AHyBROX5G40vftaR0DtLklOkohs
         5w/fFeZi80uyyFqdVdYvNZGm3xbWnD/RYhH9J33rqR1QuiPtOGyI2rj3++UXt8X9BW2T
         Cs1IDFisdb7X4BZpeuc5dK6sDRD6m2GU47hVUOC1dhHuhmNnb9qSg3+YU7QLlwSNyqcE
         4uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783749380; x=1784354180;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JXWYlcHV8kyBocpQgRM3YOKQ4YhOMcY53dOQDtkUlDg=;
        b=AWXdpANqxKQsA6Cp7mOz+Jkr50U7ufwFVmcId6bxjXqQWsIIoMWZ7OCA53VeQgKmKR
         rDybxxATBn6a6fXOtfNEq+hv4t+p19LcLsOjRCuwVnJU9JzgEl0rzVFF+KTZldm7nSe4
         VguB6QwP3iT5tuyYlM2f0m5S73X87zFVKC4kASN5KRs0olngrRnPrqq/NaFnWEG0Hjw+
         deNBjUfiSFNt8hr0iyZMEkJ9zxEJ/xCnQQawjKQt0MceLc9o81XpnNE2AoySBX42+dLU
         3aI/Qme2gMvk76vt16jNiVYoYTZGo9qj2wTLLzxLONJ9U2O8DTKZVREqkj26jjU4UoJv
         mpgg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7ERAvYw9LQWoP742nXaMEKR7ETK3vBxyWjdygmfGWLrLzuNFTfqs2fqNU6C25di25sSS5OvAACX4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxamrCGQ9F7so3GPUljIAGK8l4vo1t+zq2oJxBe/xDcZAh8AR1g
	RZpreduBr7IU26j3Q28tZOs4/EjMaSt31OpZ99atLRkMa/W6emkUXUFMTBsotD0eCLo=
X-Gm-Gg: AfdE7cnyErkqR44ndtkoBFZkVlU3MdYtiA/7uAjU7X0Y7wwD3U82akLoDV4kqUZ7Yhd
	9SOmIUviUkPxsn5o2fDQIYA0Pen2kUWOazzT31UW5X1bj97mxNx3NMZr/C2eba8Oop4h+8ujyh2
	8pLXiQj2J10y9W+ziJtLAMXZ1KzCWB3Yx7lFqN0CSZg6RXeyCJvneOkRJB3XSOkuVcDv9qfPAP7
	sQZ77W6MY/tRPmr5+jVw4E0d/V1zZZfQ3VXABk/J3FOdHWaZzJwGsIfkQYSmfrhsbbe3AFTkLIv
	qnLaQYdy7mlx8++UHyxw21HGXtNb1461KbIuPqEXkK7ODufKWLhiRKhykC3tR08l509+azY2qxZ
	ZGDhMQOE0nwrCqC35/ShG51Qt+5a6hnmbf0KeGxlAdzry5Gz15/MN13lPCr33cg8/Ms5IDP/Ign
	Q=
X-Received: by 2002:a05:6000:4a05:b0:47f:2906:b551 with SMTP id ffacd0b85a97d-47f2dd2113dmr1544164f8f.32.1783749379539;
        Fri, 10 Jul 2026 22:56:19 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26dc::3df:54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm65233731f8f.13.2026.07.10.22.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 22:56:18 -0700 (PDT)
Date: Sat, 11 Jul 2026 06:56:18 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH 6.18.y] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <alHapJgHNRea7eZz@matt-Precision-5490>
References: <20260710095359.2643791-1-matt@readmodwrite.com>
 <886c23ff-7dca-4679-9d2b-ca499523853c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886c23ff-7dca-4679-9d2b-ca499523853c@paulmck-laptop>

On Fri, Jul 10, 2026 at 11:16:27AM -0700, Paul E. McKenney wrote:
> 
> This does look plausible, thank you!  However, it does not apply cleanly
> to either current mainline or my -rcu tree.
> 
> Judging from the subject line, this is against v6.18 rather than current
> mainline, correct?  If so, would you be willing to forward-port it?

Yeah, my bad. Since the SRCU code in mainline fixed the original
deadlock I reported I kept this to 6.18. But I'm happy to forward port
this patch too.

Thanks,
Matt
