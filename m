Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8438C437
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811319; cv=none; b=DvkfpoiCGHKhmLnzlAmQ0qYH/zhz3no58AcMtiGIknYIR5lKQ57l2e6FV3CSXF1Mh/elqY8cIScH/0htWGlowyeIOhycEz+F8yRkG2opVrUaksjJYS4cTQxSUCjOUj9ub3/fGVbAvIZWA87HgmllYYFpekJtZiWZRXJNKBY8Kxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811319; c=relaxed/simple;
	bh=ZsgfwaWQ/k/9S7dCTq9cmP+83fNx4+hdg55zwZq3nX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5/Q+a4JVDwgAtdTAy1tC88a5L0BITcIZpp9ZZy+/00UX85Lwxnlu+M3EeQM+gIDKnyHcouzwm4eqkF7uMwpmbV0ZiIAW9oxMpBfAw2sev7vsGeQDdxZtAyo51gwK1WplfBwIdOWIRRiJlH41aKgJPr26oBKvSyNf4EG9mIf/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eQ23D18c; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eQ23D18c"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so3569649f8f.1
        for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782811317; x=1783416117; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNTfDa2UJEPkdFDHQ+TrUrTOUtTro7Mdn22skuoNakY=;
        b=eQ23D18cqXry2RqtGZCiahMyfjCF/2Ur3lCuRhK+NrZM3NyI/ts+rLWLrKIa+ejjZ/
         wCARlkg3FDemRH+jQyl59R7mAFxWzrosn71xKqp3P4Dg4UmehSpD0MXpAblhQm7h/e2K
         zab08CP2u61twS+2DGHIyVr2cTMJqAV5fVlcPuKqc1VtmZcLGy25R9Z0hprVxt/4B6AF
         OfAJAasPhI1e51nIXPsBOO4IQN7YOtlw66rQbBliQraKXb9h3nfW5k6yHYZId7Shf+C0
         9REzSpFMzCniTIpsAz66Hl0+iKzrl8IKpbTqk3WvoxXiyClKfHCxwO+b+ADKACoGc+fA
         Lqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811317; x=1783416117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lNTfDa2UJEPkdFDHQ+TrUrTOUtTro7Mdn22skuoNakY=;
        b=qL3hItqkDmIK4JT0jn/3i+uMgOo8fVdGRch3XT3lElDnFbicZ0yn0tyek8jO9xm+/p
         /Ib3tuCUnq+RnQ66Yxj3b0JzQVSXPD5LS9LdJZqOgY5rqfQBFF/lOmw7IwDg4vurT6m8
         y1ghIQa32GZTfktT2JWA2indK1PrXVakCkjFg3ZZ7gDCUL7nlfqdCd2+My0nlGqcmZqY
         Ym6aM4CLvly1Fcshpd4FQQJeun1saaLFOvKeSw+teR5Ww01oGBlTzSyjV665ZvweTiL1
         f2NnrntNFP37mlOypVSMTu5O71qUzrigf6ddrzzxXdKfJUXTjLBVM5viJeHujVOu663N
         mQyg==
X-Forwarded-Encrypted: i=1; AHgh+RpyZ/YMQvDxASLb0rXG2WI/rC3RTtxtPBQUtaTkLdfotGBbHhib8XIZ9zypv2GVVIx51bwlK2J/O88=@lists.linux.dev
X-Gm-Message-State: AOJu0YzLlmznmbRoZ/T1N6iwrUAAbmuSQmSNuIbA37LT/kgbCsRG6QO2
	beGHXi5kz7JrZsDWuBPV7szpbQN5p6puApIo0fJNzFk9SDz99pQb3zvA+pLvCs7iJFE=
X-Gm-Gg: AfdE7cnFlZ8IH43jR6cvnGySgt8N8pIGvzl+2ZHLo7CEWYslu+ATdiDi/EGJ5t6Qe+H
	k7xu7W+uPvU8vZ0DoRBmRj4B+AEznTphwpb58W06o/EblB0OUtRCQcFuVEdq3f/t8P+xQ6MedS6
	4HC7qZqRdq+ou4LMMOWIsdv4nlZlG63hUtNvBt4Qn6O03JfBLMYAMFSWS/gXOh3sY/gdg/b9La0
	QTd21F8hIOuS9BqKU0Nk3QjyemqODbJJlPXE4mi4JazOohnZTCzJp2VX1FOzEFvpDiyLE6y0ZZB
	ufw8dagXb0RrBkbhFyOsUgU9blT/VsDgSIZA5ayOpf9Gloo0uRM8JJ4JIFcb0xRxU01McYgSOIW
	y6ON2PadgwBLVjrl3gqk7CVjbDYk2g0plR+VAou77MAkGvqz7KHVkUjReLqCBffVQNTG4l+57TV
	ZDeNbLk6NsT9RAO7w=
X-Received: by 2002:a05:6000:240c:b0:475:f100:35f9 with SMTP id ffacd0b85a97d-475f10036efmr1371196f8f.54.1782811316975;
        Tue, 30 Jun 2026 02:21:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47566743895sm5924944f8f.25.2026.06.30.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:21:56 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:21:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <akOKsdOhfBBqVUhI@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
 <20260624062642.5DER6vrP@linutronix.de>
 <ajugq8VAciqtMx9F@pathway.suse.cz>
 <20260624152431.Ufq0jT8r@linutronix.de>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624152431.Ufq0jT8r@linutronix.de>

On Wed 2026-06-24 17:24:31, Sebastian Andrzej Siewior wrote:
> On 2026-06-24 11:17:31 [+0200], Petr Mladek wrote:
> > For Linus, it was a no-go, definitely.
> …
> > I would vote for adding the WARN_*DEFERRED() into the scheduler code
> > at least until majority of console drivers are converted to nbcon API.
> 
> I see four nbcon serial console drivers (+netconsole, + drm_log). We
> have at least four times that many console drivers. What is the
> majority from your point of view? The 8250 should cover all of x86.

Good question. IMHO, there are about 100 console drivers:

$> git grep "struct console.*= {" | wc -l
107

But I guess that many of them are some old rarely used ones.

I tried to google amount of market share from various architectures
and it seems that most spread are: arm, x86_64, and risc-v.

Arm might already be mostly covered by pl011.
x86_64 will be covered by 8250.

I am not sure about risc-v. It seems that it might use 8250 as well
at least in virtual machines. Also there is drivers/tty/hvc/hvc_riscv_sbi.c.

Hmm, 8250 might the breakpoint. Maybe, we could leave the rest as a
motivation to convert the console driver instead of adding workarounds
using the printk_deferred() mechanism.

That said, AFAIK, the netconsole is often used when the device does
not have a serial console. And it is pity that it does not have
the .write_atomic callbacks implemented.

Best Regards,
Petr
