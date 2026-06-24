Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83338D415
	for <sched-ext@lists.linux.dev>; Wed, 24 Jun 2026 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292659; cv=none; b=PCzQyHTZjWQovvYoPQVzfdPzkawxgdo0kPl0qDBUJr0yLTVP8f6Fmmf4KYJjbz9F/EYTwbXFoA+N+2bgSIAn44TUBWmANcaN2goMLQFYThG/Y9UI+EcgJtdBHJ8r2psFONT0+ksfyps6klGVPYUxebdFYytznYrOwIy2rt2QvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292659; c=relaxed/simple;
	bh=Bejh2jagMXk07J4vN4q2aCTB4moMnQx6GKX/VG2wuG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4vAN5FW91PNCdfmizfgsliZWwiiHGB9uOnmhKKffv3HOAhAAHxNZVlymriTphlFRPbLpKjHuU71p5fyB+4x9lw7cdfZtRsc9zbo3K4ONHzR+PytVhWCVDM+JSD11q4I1QXXjG+e9uXZiuyLf3br65AtyDfB34uVz6fMUp0yVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G8wG7CPF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G8wG7CPF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-460166910e6so484501f8f.2
        for <sched-ext@lists.linux.dev>; Wed, 24 Jun 2026 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782292657; x=1782897457; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMXKleFLZJBIvs4jrEU9E5muXUV27zhjMd5mE+UdPj8=;
        b=G8wG7CPFImSYxhFkBJ4JKgQmfyPLCdcEPwNJtp5krOu3n+/UhZF0xgv8GiwTzOTmtK
         tJfO4NyEp5ARIZbJdss3kcdJv/+DdHPmzrzOw5vcYYtalzIEb/n/ONqkahnhdwpscQUc
         xrP1lEe9bvncT8TaJ0z+Z1FFfweXoHKqtS9rGC+hgEukMfeMcTSyf1Cw/a7fPQ1csHt/
         dZio3CclmM/O+s5EhJkDJc69euG1yvTQMzGX0qm35fEoNaqKJkodPa8d0nVpoZlX+LrS
         ygIktpkXiaHkAZht3qItHgPZIXypZhztCuj6ySJ9VN/yctrkg8yd0I+p79v+q3/yopFM
         DtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292657; x=1782897457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMXKleFLZJBIvs4jrEU9E5muXUV27zhjMd5mE+UdPj8=;
        b=gUgb0UwijTNcqFT6kI3ka/yARuKH8yERUMO07DBdMcNPGyVNMgLiwfI4sXu5rnOkYd
         zHKk6mNaOS/7GB/tFx+a6un5DsoOvKrVamU+IITedXU/N0W19ISpmn0E7tAHoOZWmz/J
         tH5N4Avuee5SQ+1ZV6QFm0lZxLqy3CV0sbXi+mE6A17e3wqXf//B+Rnw4s8vVeI3SR5J
         yMl7rZaZkYgHQfH4xouezVHQ97rGMisG5cRX5VTGprAjMN4Fk0mX7xlk3muA2C80TY9/
         D9J0NcpLadnyLQUMpSCFk8G/+Qpczj+75J7/rCpy/fOHBLlvqCRKDDose675HJ4bg8iC
         64lQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Gh3NiKawrM0aALyRe1n/L8aEANuXBr+rv4joBHWHG6w3lM0fPRM/7mv1t9zNKOwKb5oiX377T4ag=@lists.linux.dev
X-Gm-Message-State: AOJu0YxLdyOLwO8BErVvqiSgS64iA4TuIRpO5zpmr5ggBKr/XbdGLIQp
	dbauLSSsDYU7Q7Krn7vo9iK+mchyz17GogQD6/GmlpRmJ1TVfvNpECbTGAQCqGqOxUg=
X-Gm-Gg: AfdE7ckxqdbJyK2wbRQnPN00Cxoc0hVdDpdt4Y/nPzLuFr3Auz3FW/9nGThEi75uYIW
	tat7z1MhUFveOK2NiXlW8p6FRZbgehT3qTLDqxyXGQDcHxJ66Q9rOz8UTCqCb5/3P4NPHms7br0
	4ESakIjxaZ8sMj7+FrOA9rsTG30btcNh3GGp2rPW3H0pgYZamAx/yArJnSjrlUpB9wSfHtOCFxu
	Uy09lxGUyB4bk/E3nEHuMkpMlsoIv+b0W54Pamfz5Fe8wEQanEx30p4lnjtvvqg2Ur5/+2MBXYj
	2lb278P8RiZpy52iD5G6lv5LTUrzh8HJ2B+MykqeHyfc56AWzfL5TSfQZkbRLa6sPovgUa5mulP
	1LF9TXE+GpwBC3U6vtOughj2tBoIyvWfu+7C2B5cpFA2LW4KjjZY+uouZZcF4TvBJk1bPG9Gb9M
	7yECtjpwz/rCjPQOY=
X-Received: by 2002:a05:600c:1d16:b0:492:5855:1548 with SMTP id 5b1f17b1804b1-4926087830amr31471525e9.27.1782292655197;
        Wed, 24 Jun 2026 02:17:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1f886sm412331495e9.4.2026.06.24.02.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:17:34 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:17:31 +0200
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
Message-ID: <ajugq8VAciqtMx9F@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
 <20260624062642.5DER6vrP@linutronix.de>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624062642.5DER6vrP@linutronix.de>

On Wed 2026-06-24 08:26:42, Sebastian Andrzej Siewior wrote:
> On 2026-06-23 20:24:02 [+0530], K Prateek Nayak wrote:
> > Hello Sebastian,
> Hi Prateek,
> 
> > nit.
> > 
> > Instead of replicating these bits, can we replace that return with a
> > "goto out" ...
> 
> sure
> 
> …
> > ... and replace this return with a:
> > 
> >     return (warning) ? BUG_TRAP_TYPE_WARN : BUG_TRAP_TYPE_BUG;
> > 
> > Looks a tab bit cleaner to my eyes. Thoughts?
> 
> It sure does.
> I wait for PeterZ' executive order to either do this and sprinkle sched/
> _or_ make legacy consoles deferred as it is done on RT.
> 
> Petr, was there a big push back doing it unconditionally?

For Linus, it was a no-go, definitely.

The problem are situations where the system gets stuck and panic()
is not called. This is why nbcon consoles switch to the atomic
mode in some emergency situations, see nbcon_cpu_emergency_enter(),
for example, into __warn(), oops_enter(), rcu stall, and lockdep
calls.

Moving legacy consoles to a kthread would prevent stall in situations
where printk() is called from the scheduler code. But it would cause
that some other stalls become silent.

In my opinion, we should not move the legacy consoles to a kthread
by default. I believe that the rest of the kernel is a bigger
source of possible stalls than the scheduler. So, the overall
experience will be better if we keep the status quo.

I would vote for adding the WARN_*DEFERRED() into the scheduler code
at least until majority of console drivers are converted to nbcon API.

Best Regards,
Petr
