Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B413446B6
	for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142524; cv=none; b=H59LPbag13fTjaeYC0/ed9ENYtWRy43AONLfUfuHdS8EmxhQlj39oR9p+D9EmQFKDTeNFC4ks/aW84g22XLrIusgoREW5eQrB6ymLsmR0SApdXYKRjNEajXs1aOSXQ7pCZj+qOrkWP9DOKtqV6zYRed2SiNaBwYh9of+DXs1bjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142524; c=relaxed/simple;
	bh=7V+XeZgw3ANN77+vPCxu6yzaCB1t8ks/x0sHCapzNrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0QonQGkHL5v4GNsefqGZu/8pFtOsGOHwMiFCmPYapXLff0xxfml7/5mvrF63vnWjPaxPaqAqWoi4mzB7ybEjdj43oYcM1x9gO9tEmth3RrD+kG4JePkJof0t36fVyasOg9vYDFA4ReKvZjiaZbJ/IbQyfMbML9jWg2JAV/t39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GHRYxpji; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GHRYxpji"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae77516so25130285e9.1
        for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763142521; x=1763747321; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTMQPJoV4ZgBH6Thg3JMd1LwLz0NHXt6GDT5LGUd8Vs=;
        b=GHRYxpji/lUFiJ2s0cno1sL2b5BLg0LMBJu0G6XxtLSbzBRDRefSIVxYPmfFA6H8MD
         fOSdewAUA5PXVVBTYOFKCOTZjdJFprsevmACHCs1rw30o+NspN4vuvWWvnZJejq+AP77
         bC/BJQ+IQ5jRlG5Xr5bL9XW+YiLjyGs8N/7nOjxH6LI4I8fGMaoTyvrOYqXjpyFFHCIc
         8FIszAI/ywIEEAgTzYA8+U2KU38uPkPx+9n3kPFoFaIR9tS0PZXRgsU06HH4+NK9q5ti
         Li5Fl8cj1t43sDbs4+5b/jHbbnzdtpOG68ahzVxisHTmzR7E5HM/gBMyR90t2kk0Nt1k
         +UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142521; x=1763747321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTMQPJoV4ZgBH6Thg3JMd1LwLz0NHXt6GDT5LGUd8Vs=;
        b=eooXsD0mvqqojUDw6tVJaPPHqEBwSYRBhWgulrVU8VGtSOGDy4fHbXb6a9Vhh8V3vN
         C8RxUXZVWNo9dwyhO4/ljEA6BvcUXweqbFMluQMlRHfhTr5PeCDGCcTWbfOtGsWp8ay2
         93ckah648ffUn6F2XWHRavTNy2ZX0+OlWDURiOWx1cxy9pZukQBXogxjMVj3UD2qSYc1
         KN5rMdj2llM4tru4ZlDLnC03bsWt/TJKIqDKQw9b0sJ9Cc7xXncp2zJ4ZuqKODaBHZW3
         UvxiXza0RaSyixJxuNZ5ulMwBAonyShp46JiPTKNp4V/Rw6LV59RYtE8RcE0MQUWKPOz
         Sjiw==
X-Forwarded-Encrypted: i=1; AJvYcCXCOc8vOsGZWIVbJha99arUMsU3OwhcZYWSSvz5MwIfVpGhyB96slUrMkUlPwztQEVsaN5ApwLSBGw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs8LhGZd0zgZzFaP/6yKloSprM3l1OctrPm6lcWSvODXL9yZ36
	pobC6hWHiuAvGQWwO/hTF1+ZYDSxAhiygki+nS00OAlWryDwjC6eDzMdLcC3EbWPFos1QukYEwE
	i8nzJ
X-Gm-Gg: ASbGncuN+6g/rSo1FjY3lTGyWAOXeJhJbFH/vaWoCcK6wxoEjPuUuINMvA/MPehKnOO
	u1OoZuGIyEG+rbLiymlJPfGSajaxjHletIasW6/5rPceZLmIx6DiLGHaH1BK1aXX6WyI/+eZQ+m
	3eK2dXT9km6IVk/6vhMRIUNcXWDCSFMqf25jUKYgbu2AKAwyfq2TQwloEYT6rhUhCz/ibE/uO3W
	2bQ6CE3Tq8sHTlMOaWsssdGdBHnnXpH2wZCDbI+aPomyW3b+faSOoXcM7SWNA+pTV0dnNUT0ZyG
	68+1MqOqtH0I3+o6nv/EjSaQ5y//tPZQ8WXV+bXwta85MTuxZ4Lfb+q2rsnAEYwkPNirlRfDL8H
	mWy62BEysIaTlEiLVXHWu172I4FQ9PP1gLO1vB3gdhi8BmXdqTfkEowZ8mdL1Wb7757upyyjnfz
	89+tZrrt67QIk3JcaAg45H
X-Google-Smtp-Source: AGHT+IH2xud28gYZ+H62Z6lkklRfg/TIad9tpaWDZW3kXUS1Y4xxjzGN1y6b5Rw7PdKjNP3p2x01oA==
X-Received: by 2002:a05:600c:548d:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4778fe51db3mr38596455e9.2.1763142520765;
        Fri, 14 Nov 2025 09:48:40 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477952823d3sm19291225e9.11.2025.11.14.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:48:40 -0800 (PST)
Date: Fri, 14 Nov 2025 18:48:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <dschatzberg@meta.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/4] cgroup: Defer task cgroup unlink until after the
 task is done switching out
Message-ID: <wrcmeb2ooxyr5ygix4xy5j4gffb3oke4tcgjv3zdjfvhykoasg@splg4qifdxxo>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ul2jo6dszlc6rslz"
Content-Disposition: inline
In-Reply-To: <20251029061918.4179554-4-tj@kernel.org>


--ul2jo6dszlc6rslz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] cgroup: Defer task cgroup unlink until after the
 task is done switching out
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 08:19:17PM -1000, Tejun Heo <tj@kernel.org> wrote:
> When a task exits, css_set_move_task(tsk, cset, NULL, false) unlinks the =
task
> from its cgroup. From the cgroup's perspective, the task is now gone. If =
this
> makes the cgroup empty, it can be removed, triggering ->css_offline() cal=
lbacks
> that notify controllers the cgroup is going offline resource-wise.
>=20
> However, the exiting task can still run, perform memory operations, and s=
chedule
> until the final context switch in finish_task_switch().
> This creates a confusing
> situation where controllers are told a cgroup is offline while resource
> activities are still happening in it.

(FWIW, I've always considered it impossible to (mm) charge into offlined
memcgs. Alhtogh I don't remember whether anything _relied_ on that...

> While this hasn't broken existing controllers,

=2E.. so hopefully not.)

>=20
> Split cgroup_task_exit() into two functions. cgroup_task_exit() now only =
calls
> the subsystem exit callbacks and continues to be called from do_exit(). T=
he
> css_set cleanup is moved to the new cgroup_task_dead() which is called fr=
om
> finish_task_switch() after the final context switch, so that the cgroup o=
nly
> appears empty after the task is truly done running.
>=20
> This also reorders operations so that subsys->exit() is now called before
> unlinking from the cgroup, which shouldn't break anything.
>=20
> Cc: Dan Schatzberg <dschatzberg@meta.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/cgroup.h |  2 ++
>  kernel/cgroup/cgroup.c | 23 ++++++++++++++---------
>  kernel/sched/core.c    |  2 ++
>  3 files changed, 18 insertions(+), 9 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

>=20
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 4068035176c4..bc892e3b37ee 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -138,6 +138,7 @@ extern void cgroup_cancel_fork(struct task_struct *p,
>  extern void cgroup_post_fork(struct task_struct *p,
>  			     struct kernel_clone_args *kargs);
>  void cgroup_task_exit(struct task_struct *p);
> +void cgroup_task_dead(struct task_struct *p);
>  void cgroup_task_release(struct task_struct *p);
>  void cgroup_task_free(struct task_struct *p);

"Hi, I'm four-stage process, you may remember me such callbacks as
css_killed and css_release."

--ul2jo6dszlc6rslz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRdrdBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ah5xgD6A1MLrMhxe8DkMTE6H4Ec
S//OOnd8AWbJP2Lw1LN17U0A/iYN6bny8iWy2XZcdySr7UzWZ4/t6pe3oSHlbXke
AigP
=FkM3
-----END PGP SIGNATURE-----

--ul2jo6dszlc6rslz--
