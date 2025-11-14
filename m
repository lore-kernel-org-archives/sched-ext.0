Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F373446C7
	for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142504; cv=none; b=u6yubxM6vzsQAxyyACIHWmg2eK8cEsafyJ8/9CuLnY22StpDF7taWMQVt9dh9wGppHfoC2CaDYJPC2boDLxmhVP1GSK2F/gSrNvA7hLdRfpWdm0jVUV/jLOlba4+I8T+mdAXI6YxuDqQWTiABCbZvoLbw/ioEA3b4fm9kYGeVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142504; c=relaxed/simple;
	bh=adgZ6OK/I9H/U8sQcgAcMsvimT/wOtV4kBOT9ZAu4RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUl6Vhjw6tigl8sCQxUu1ncp+izEELvqUYAEeqwu3kAHZL+rIH+wap4IjHR+oVA+LwblvxsdgBWg5CR01NaX1O0BGEvM/bmAVH3KHB2uUVzLEvTxD9E992Nr2xlK34Rc28d+OGxm5CkhqG0wsSJ474yCpTAdnG5kHgggQX2YrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GghZRQki; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GghZRQki"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b39d51dcfso1215953f8f.2
        for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763142500; x=1763747300; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=adgZ6OK/I9H/U8sQcgAcMsvimT/wOtV4kBOT9ZAu4RY=;
        b=GghZRQkiauz6WxsJOdfe5t3zB4jqaSURW02XrSdPFteiJJxx/q6OSUihs1Izua7Dnt
         jPQGvnXkHN4+ajwyBNytCoIcZBcE1bIuwq/akGzVzQhg4vJmIL3EFK/rB1eflM6+h33g
         NLQ9CLiQK97ZfyijfLpDvc74TwjQd33jzzIDN6y45K1VLXNqVEXULfu3tZWT7vIz08uG
         pRjXTtN4g3uYpvoQJ5pNCERG+D+tFQGUZDaNv2Ha5dJGfdCysJuliVm8R+ZSurMjrSNr
         FdNseIKgv40m0SQpaUeBl0pqmUO2k5WtVJbsss5/Um4RQXOE/lzkubDK+EaaLNcCCaOO
         Z16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142500; x=1763747300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adgZ6OK/I9H/U8sQcgAcMsvimT/wOtV4kBOT9ZAu4RY=;
        b=St1P5BQNNe5RUTIc9czBG2DplUVRYBak0kwTMlwLZvwkwh0iUpgdFJtX4SkcY9PwVq
         01GgHcCS1Dm74hH5zT5p2bNu55/oBI+cfNzNzAkyp4elvYU9XOn/gNgQnwXyqFgwnQlj
         SFrfsgC2KfAxXDisQ+hhxv8U7g9rj8f2AvjDgjOcO7q3jQ27cA+pn6R0V4RaJ79a8xPD
         FfrBP02mxFDhd55wOYDWFnfoUQIVvMbzS+gp7sLFeJvGa1BA/qr6W3UccS1N7dwjXXXQ
         iaaCTSog4nLhPb7Dk7DqBszqKikiD/bYmE7NwC3WNOo+y+9k1Skh+L6PNQEmXu3VF/4G
         6y8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsyWO+4mOwOk04Yo88YEXkFHHEFH73Cz7ypRsC+0ychgYF58iytT0Ce2E9PF7O9uSCUyjo11oFGw0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxR3UiXpRjfKpDhd9g7WtAxaLKCBFnbobyRwFvAxNNWuOdeIUQ5
	SSX8wHn3HvO4jTJWk64s6G9Q3bk/DsNraBPFHczG+FzHoVswCTwxQxvZr0r7eF1EShY=
X-Gm-Gg: ASbGnctaeHt9bx4nSQTetw4JyhPykts2OC3yuWwKeKPFHz0rnQ9mcYjAk8bw935q2Hn
	EfwFJMrJWJTIsfl7lvyXHjkQ8Hq06/67v7GOBCQCVLAVjwFDykFc0/IHL16XjHwV2SEk5r0y97F
	DYW612YD6Bgpa58C/SzUTgPVTyk5WTANPrfpz3gr+2UIbT6GK0j0x8TciQe/Gv0lhgN5Bsq9SNe
	Nlxzs6PLDKevvuhOuPAc6AeK/c0F4z20Ns65iuvGWS7sR66fyLvXLUvdRL3K9A4C2ocd2SB/TFg
	4Sya6YSkj/YLNM6Uo+FQayOKqP9TYsihP4SAmapb7IiPmVRGByY+g1huGVn4+THTPYmsYsmKWWy
	LgSaCHmiI/BLJsnPMBGDMUaFy9ewEYD8i2dw8/UkG9EgHx+XZjxpGcmcjfkPovlvbAMukrJKjiO
	2FqQj0VaJqGPWgrkvSaA+l
X-Google-Smtp-Source: AGHT+IGfqZxTVDZTeDBSihyOagzRQuVA2NQSR8GN+UiOM9xyyrGY6jNAtOzIVK8gI8hxZWVnxLGQAg==
X-Received: by 2002:a05:6000:4383:b0:42b:3c8d:1932 with SMTP id ffacd0b85a97d-42b59345301mr3744589f8f.23.1763142500182;
        Fri, 14 Nov 2025 09:48:20 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm11658313f8f.17.2025.11.14.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:48:19 -0800 (PST)
Date: Fri, 14 Nov 2025 18:48:17 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <dschatzberg@meta.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/4] cgroup: Move dying_tasks cleanup from
 cgroup_task_release() to cgroup_task_free()
Message-ID: <acjwpiayukusza5tybuhg7edwu2hjea3vpopxgukoc7pqc4d2s@qtcptnu44vyf>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3kggvokzmyvkuvuk"
Content-Disposition: inline
In-Reply-To: <20251029061918.4179554-3-tj@kernel.org>


--3kggvokzmyvkuvuk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] cgroup: Move dying_tasks cleanup from
 cgroup_task_release() to cgroup_task_free()
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 08:19:16PM -1000, Tejun Heo <tj@kernel.org> wrote:
> Currently, cgroup_task_exit() adds thread group leaders with live member
> threads to their css_set's dying_tasks list (so cgroup.procs iteration can
> still see the leader), and cgroup_task_release() later removes them with
> list_del_init(&task->cg_list).
>=20
> An upcoming patch will defer the dying_tasks list addition, moving it from
> cgroup_task_exit() (called from do_exit()) to a new function called from
> finish_task_switch().
> However, release_task() (which calls
> cgroup_task_release()) can run either before or after finish_task_switch(=
),

Just for better understanding -- when can release_task() run before
finish_task_switch()?

> creating a race where cgroup_task_release() might try to remove the task =
=66rom
> dying_tasks before or while it's being added.
>=20
> Move the list_del_init() from cgroup_task_release() to cgroup_task_free()=
 to
> fix this race. cgroup_task_free() runs from __put_task_struct(), which is
> always after both paths, making the cleanup safe.

(Ah, now I get the reasoning of more likely pids '0' for CSS_TASK_ITER_PROC=
S.)

Thanks,
Michal

--3kggvokzmyvkuvuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRdrXxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjAVAEA+MiTNuMxizSa+5JF74pj
6kyfERptGG15W7yN848dLqoBAKjW2f4y51/zFdSBNGBGE3gO2Hu0BbLlXVMVULHC
qfIP
=1O1J
-----END PGP SIGNATURE-----

--3kggvokzmyvkuvuk--
