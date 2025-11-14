Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865641C72
	for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763085667; cv=none; b=MECWqC8xGu/7QkpNLc0L+WJQlDBxZuWlsf+a2i/5CPm/gkhVp9zlOSwpv7kQH1VGPZcKtY+E+KWsG4gd8UeV5sFUcGAewIFnosg7B6ol3JQVM5koXTuabAY/pSpycYizYw2pDrLSAQsSXCzO+FfVyURV84DTwVhEM/sSaWie1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763085667; c=relaxed/simple;
	bh=Ptwj/jKFzSqEHee0r1Z2dr8I/pYZzSwZL0MWDldJBx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af7rbEOjOWfvaJqMpEF4DK7fHiLUXhQiCyznskF/3aXeQYfSFQ82lqBltd0V4ro7UfQdE+S+UFPx7ST2KJMAJGA4ji0nvtmPtUw4v7RB63ePvdtKmMyb4sNEgsdtkGS212bJV5Bmv1jcd5/yrwgrBQJ6rWW8/+jZs3Ejds4e98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=UtL7iBjD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="UtL7iBjD"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787e7aa1631so27423517b3.1
        for <sched-ext@lists.linux.dev>; Thu, 13 Nov 2025 18:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763085662; x=1763690462; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKtIAtK9GSTuKKAh/nnPGHpyzwreHBcPkr+/g+4GNNc=;
        b=UtL7iBjDPqpXOJDUr6CyL2UUcH2QGnyUAMWR5QWTWyJFLgu5abAmfYYIvfmlvAu3yq
         9BIojcYGU+AfqT/gFduwDSBc9hWx0qiWGyraoeETGdPfBsTp1BXTFGMqifDllmvFQ3ss
         jIFNE+F/zCzd0JDNMToXlKgJmkA2/1bLAxfQgX0Hmkv/KuPPLSuYhtp5BWZuok+UejYu
         lZOzre2CNbuyf8F6KfRajUOv03CnxXuQTr/ot5TU/VahfyaoC+k/5ZTj9516wvn9jXv+
         FRUpDYA37czLNOsCc4hauyxfMPCeEr8JLk2+9Ta50dVurgEsvilnNtZVgJ8dbNRLhMqy
         E+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763085662; x=1763690462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKtIAtK9GSTuKKAh/nnPGHpyzwreHBcPkr+/g+4GNNc=;
        b=fLgPncKYeyHEEAr7OT9cSbhaN3E1mZa5mHBh27pFq47JQEJ22nW6GoWHJVs20Lryk1
         7Tg3lxec2kB/2kUaToPqT/1uuIlMZmZFlbGOfbHENJEc09UOveqd2BLAuj3e+ZvY7p4O
         tkutuCdbYUuITdxOM/4J7xtmQe24NZH2eXp2SmkQOBYitf8JSp+rIIica7HYhXtDbGss
         J1cNOnU9Ehyf+sXg6nMZbSFjOOoaeBHgniF7kcSxDaBjjWQ14uKGthsq45+N9FcT/Gaf
         TsuhX1I3zQ7Jeksc2lI15JmRMjVNdSwsxyfUVtqDNCLHpRIeplPHziWYUc0fvSGSVATE
         xvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd0QI3lYM9tx+oR9+V/iWWXgPpy0xsCql5f9L3gBA1s6sI+f67IdRf1l8iHO9uj7AIX3dmaUOheoE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzyEJCd2VErE5b4pcAEZlVwC4/U1OIyPf+BR+KIeHnOkdy3cMGU
	UUpnF1lWdp0Pm2WRKaam0VpagH/gyq/5vA+ERLhUjbbVqpJwobDc/EOrB0IN+n8CxvNxCqOaEKN
	6RPTMLlt7s+PrWGFaZeP30mKqhCuzKD3UJpMz3nVjng==
X-Gm-Gg: ASbGncuO014eNZzDKuQAIQGEIRMxW1Xl0nH0LeUg9ycp2SeEDmw31QGVcEvGy4Hpnm9
	Bf5dyWI5LpRO/XmYRl1BYrHxLBd69PfU+9fbljSCymC0/+N7bfihi8iumfpnFNIlDj3yNiGJVtL
	z8QXL3A/UFSH1P87jG672rosnXj7TQchjsF3z8ZXRmlgJweW4cGUlemzle6h2+vEM3j+W9dQH95
	QE4wN/NW6NWicbXdWYP16WFTG70+KhEWk8yvfA+2/iTDCQx1blaYlJa8USLpeY=
X-Google-Smtp-Source: AGHT+IHoh15YcosnFdk7jzKBNGtF0rAES0wm9xoPxpXzolGwEYCPvmkuI4B7PHCBHDelMZ3Iez+BCVxvLSRp3HyMVao=
X-Received: by 2002:a05:690c:d95:b0:783:7768:55e6 with SMTP id
 00721157ae682-788205edd86mr50060637b3.13.1763085661898; Thu, 13 Nov 2025
 18:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251111191816.862797-1-tj@kernel.org> <20251111191816.862797-10-tj@kernel.org>
 <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com> <aRaG9X9xfS_QL2QF@slm.duckdns.org>
In-Reply-To: <aRaG9X9xfS_QL2QF@slm.duckdns.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Thu, 13 Nov 2025 21:00:51 -0500
X-Gm-Features: AWmQ_bkiCXwKJYfDtHom4gHUG5fqKpkr09SmxmyoF36oLe-EJLn_w-q-6XZxn9w
Message-ID: <CABFh=a7WYYmhO-q_VbSCc8c5E24gRzB05MG2Yc9+ev5TM14sMQ@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Pass locked CPU parameter
 to scx_hardlockup() and add docs
To: Tejun Heo <tj@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <andrea.righi@linux.dev>, Changwoo Min <changwoo@igalia.com>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>, Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:34=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> With the buddy lockup detector, smp_processor_id() returns the detecting =
CPU,
> not the locked CPU, making scx_hardlockup()'s printouts confusing. Pass t=
he
> locked CPU number from watchdog_hardlockup_check() as a parameter instead=
.
>
> Also add kerneldoc comments to handle_lockup(), scx_hardlockup(), and
> scx_rcu_cpu_stall() documenting their return value semantics.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  include/linux/sched/ext.h |    4 ++--
>  kernel/sched/ext.c        |   25 ++++++++++++++++++++++---
>  kernel/watchdog.c         |    2 +-
>  3 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 70ee5c28a74d..bcb962d5ee7d 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -230,7 +230,7 @@ struct sched_ext_entity {
>  void sched_ext_dead(struct task_struct *p);
>  void print_scx_info(const char *log_lvl, struct task_struct *p);
>  void scx_softlockup(u32 dur_s);
> -bool scx_hardlockup(void);
> +bool scx_hardlockup(int cpu);
>  bool scx_rcu_cpu_stall(void);
>
>  #else  /* !CONFIG_SCHED_CLASS_EXT */
> @@ -238,7 +238,7 @@ bool scx_rcu_cpu_stall(void);
>  static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struc=
t *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
> -static inline bool scx_hardlockup(void) { return false; }
> +static inline bool scx_hardlockup(int cpu) { return false; }
>  static inline bool scx_rcu_cpu_stall(void) { return false; }
>
>  #endif /* CONFIG_SCHED_CLASS_EXT */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 8a3b8f64a06b..918573f3f088 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3687,6 +3687,17 @@ bool scx_allow_ttwu_queue(const struct task_struct=
 *p)
>         return false;
>  }
>
> +/**
> + * handle_lockup - sched_ext common lockup handler
> + * @fmt: format string
> + *
> + * Called on system stall or lockup condition and initiates abort of sch=
ed_ext
> + * if enabled, which may resolve the reported lockup.
> + *
> + * Returns %true if sched_ext is enabled and abort was initiated, which =
may
> + * resolve the lockup. %false if sched_ext is not enabled or abort was a=
lready
> + * initiated by someone else.
> + */
>  static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  {
>         struct scx_sched *sch;
> @@ -3718,6 +3729,10 @@ static __printf(1, 2) bool handle_lockup(const cha=
r *fmt, ...)
>   * that may not be caused by the current BPF scheduler, try kicking out =
the
>   * current scheduler in an attempt to recover the system to a good state=
 before
>   * issuing panics.
> + *
> + * Returns %true if sched_ext is enabled and abort was initiated, which =
may
> + * resolve the reported RCU stall. %false if sched_ext is not enabled or=
 someone
> + * else already initiated abort.
>   */
>  bool scx_rcu_cpu_stall(void)
>  {
> @@ -3750,14 +3765,18 @@ void scx_softlockup(u32 dur_s)
>   * numerous affinitized tasks in a single queue and directing all CPUs a=
t it.
>   * Try kicking out the current scheduler in an attempt to recover the sy=
stem to
>   * a good state before taking more drastic actions.
> + *
> + * Returns %true if sched_ext is enabled and abort was initiated, which =
may
> + * resolve the reported hardlockdup. %false if sched_ext is not enabled =
or
> + * someone else already initiated abort.
>   */
> -bool scx_hardlockup(void)
> +bool scx_hardlockup(int cpu)
>  {
> -       if (!handle_lockup("hard lockup - CPU %d", smp_processor_id()))
> +       if (!handle_lockup("hard lockup - CPU %d", cpu))
>                 return false;
>
>         printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabl=
ing BPF scheduler\n",
> -                       smp_processor_id());
> +                       cpu);
>         return true;
>  }
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 8dfac4a8f587..873020a2a581 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -203,7 +203,7 @@ void watchdog_hardlockup_check(unsigned int cpu, stru=
ct pt_regs *regs)
>                  * only once when sched_ext is enabled and will immediate=
ly
>                  * abort the BPF scheduler and print out a warning messag=
e.
>                  */
> -               if (scx_hardlockup())
> +               if (scx_hardlockup(cpu))
>                         return;
>
>                 /* Only print hardlockups once. */
>
