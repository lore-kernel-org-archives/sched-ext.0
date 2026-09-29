Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82950EBFE
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689686; cv=none; b=HdX//Q5dpt1GGj0DedV2RKT64CxRJQUaaUd/HT8OGl4sY9TmQDhp3qp6DXssNlEtfbv9W1TuF+G9vUnEGPD6AvI8K3kJwnONn2U0sOXijlSKp4wyPzgttegVq0CJO8DxXV3LxzxwCOzx+5firou1hsSO3RQ30ttiGaLIP3xEZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689686; c=relaxed/simple;
	bh=kjgT10zxt//mFsH7+VNUVd3BXTk/uv6Q4vKSQsdNPzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tysIhqbNaPdaYh9dLIivPuTJqRpAx6lJnK2Kcpg3a+5CzakN8D6uMR1RiOe0UP5qI1PcTQaVGTpmBS3mYVnd7QuxJUPD0Qzm/qcQhAcO+JjgvTmG/KTQJDtUuwZqq9J3LkdZOzl35kniRRQ5pmuzmSA5R3GhVgBvPN+021fGmkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f/VjqLyG; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f/VjqLyG"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so3724485e9.1
        for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790689682; x=1791294482; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qHLrFhBog0zePI2Kd8NF40LmUZLMJqPvBQK1I/mAWro=;
        b=f/VjqLyG7NR9dHJ3CAAFC+p/YMR8U74EIBeQvnZBxjugaQtksBfmmRayadWKwQWGsx
         Mil5MLm2iuh5FGYCL3mFFBwfxSmVpj7LF0EoW7B7455XEWNKqjiBLq/KHy4Zz6kDfRH8
         zkgRWESJkuEwG8EBDHjoVq9gPE6Z7icxirzgBpB5LNr26ZuXmlh6garuysPUmrLccb9I
         gnU15ffM++DobyAAykX5m4+B/8LH4FJAo8zqdnDQ/FEh/hjvwtGZBGCVdZVP1bLcvLiU
         cMCI5qpuKr3ZXCeszVQwEjBb+h+baVEgjQIS4hxmkwft0kcSWDw7jWruQed/921zv9LS
         U6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689682; x=1791294482;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qHLrFhBog0zePI2Kd8NF40LmUZLMJqPvBQK1I/mAWro=;
        b=AzeKI9DelqLGWkrTDDIhfftIPGUYzwe/oez8LIcCCxnL5DuBW8WGvra5wgxcOJ3wlY
         bMY1R/vK3NZLO9tPvHLc28U00mx+V9pY/LotqDLCoRjATuSnaJM72j3Iqj7wI6zUSQ7S
         NVAlCkhoQ7gSGa3miV86jd5Bw1KXO4ehqLMBsZnGUME6PUmk8omY67L6j+DO6XyOeHY/
         DyoPiFMGA1GUTtUxNYbksaGWOvfkjXJXJD6VbQcr0cZKszMjCAUXs6jVMRahExFTvmm4
         Pgmyfe3yMjflGHYqGiyFDKVEFKe/BOrbN76r7+daH7qadx1P5cmmgp0un6wJFEsdBt+j
         sFgw==
X-Forwarded-Encrypted: i=1; AKwUvBz2MqCBl2B1P0MXXDJlIb/XJpLW3TCPlMlgxTOsOtpppzW9PXgnSo2ceec1WFv72OxnH+1KtXtqroI=@lists.linux.dev
X-Gm-Message-State: AFuF++lCXjj5rGFqE9G7h5Xmi+v+GBgjN6sNmtAl6CvdGn+4M2MDmuH4
	ek3oOO70PDHSKsRDj6nKxFun5385TXYapBPyctZgvYZWCHoREraogcQo7D1r+EFqCmY=
X-Gm-Gg: AYBFou2OLSPbc2chOPtQNXIzpA9TkI/t8n5ieAppHHgkdPyPiuTSkOxckH9m15murWk
	rvArEVikd1z4LnmwTTXXlUqxgsDZimYNx07BtJHc+hSX/jYU7S/JL7yPXFgE7BdWVvAlOKXa+DH
	FHjB7w/RAU8zJaiLxxm2NBDFjCsC/5MwKwbdkusXmFgzRE48qVi4ENZuIgqVeZBDA7tR7gt3cRg
	VQRaDeSVTCQ2tLpNECLi4arsEi064XtmpFJMnffKVRxhYy8dedHfVFssXGGQ8e28KIUQUV0MXo1
	JUaXxS5lQuJ8lU+03p5/7S6R8PpLcmqIjxj8eP0M4BMxRMSYrX2IVzChUQoObMwPeb5iE+o8wG+
	n8kAZjbDxicyIm61JunDI/FG4GsL9de+dycLEpIUXOi4MHN/c4dlvBH4r3zz61Yp52jbpLP+Vt7
	7avKSoTM0BZX0VI8wokQVZqNVpVvcPHUmtgAqF9tGieyKE0/XFJq5oz0h9MKb1BQXAZ4NpVcKNS
	A==
X-Received: by 2002:a05:600c:4e41:b0:49e:715d:95ca with SMTP id 5b1f17b1804b1-4a00d778ed3mr39485165e9.13.1790689682061;
        Tue, 29 Sep 2026 06:48:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013d1ea8csm2107475e9.3.2026.09.29.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:48:01 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:47:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cgroup/cpuset: Protect is_in_v2_mode() in
 cpuset_num_cpus()
Message-ID: <20260929-making-language-254d9c6a6605@there>
References: <20260929084124.626693-1-arighi@nvidia.com>
 <20260929084124.626693-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6lhaepxnk64h7feb"
Content-Disposition: inline
In-Reply-To: <20260929084124.626693-2-arighi@nvidia.com>


--6lhaepxnk64h7feb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] cgroup/cpuset: Protect is_in_v2_mode() in
 cpuset_num_cpus()
MIME-Version: 1.0

Hi.

On Tue, Sep 29, 2026 at 10:37:38AM +0200, Andrea Righi <arighi@nvidia.com> =
wrote:
> cpuset_num_cpus() enters its RCU read-side section only after checking
> is_in_v2_mode(). When cpuset is bound to a v1 hierarchy, is_in_v2_mode()
> dereferences cpuset_cgrp_subsys.root, which is freed via kfree_rcu()
> once that hierarchy is destroyed and cpuset is rebound to the default
> hierarchy. A preemptible caller outside RCU can therefore read the flags
> of a freed root.
>=20
> The only current caller, fair's group share calculation, runs under the
> rq lock with preemption disabled, so it can't hit this. However, the
> helper already means to protect itself with RCU, and upcoming sched_ext
> support exposes it to sleepable BPF programs.
>=20
> Take the RCU read lock before is_in_v2_mode() so that the whole lookup
> is protected regardless of the caller's context.

This feels like mere querying of the mode shouldn't require such
constraints (despite it's needed anyway later down). But it could truly
happen with the novel usage (CONFIG_CPUSET_V1 && unmounting cpuset
hierarchy for some reason, I wonder how you noticed :)).

Then I'd welcome more structured approach with at least:

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 3754d697854b3..7f4d346cfb119 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -841,7 +841,7 @@ struct cgroup_subsys {
        const char *legacy_name;

        /* link to parent, protected by cgroup_lock() */
-       struct cgroup_root *root;
+       struct cgroup_root __rcu *root;

        /* idr for css->id */
        struct idr css_idr;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 227d09704ca59..a718b5f521fb2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1909,7 +1909,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u=
32 ss_mask)
                /* rebind */
                RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
                rcu_assign_pointer(dcgrp->subsys[ssid], css);
-               ss->root =3D dst_root;
+               rcu_assign_pointer(ss->root, dst_root);

                spin_lock_irq(&css_set_lock);
                css->cgroup =3D dcgrp;


However, if I zoom out, I see that the intention of reading cpuset's
nr_cpus from the scheduler is meant for setups where cpuset tree ~ cpu
tree:

| * This only really works for cgroup-v2 where all the controllers are moun=
ted
| * in the same hierarchy. If not cgroup-v2 or no cpuset controller is
| * configured it reverts to num_online_cpus().

Hence it may be just OK to do:

        int nr =3D num_online_cpus();
        struct cpuset *cs;

-       if (is_in_v2_mode()) {
+       if (cpuset_v2()) {
                guard(rcu)();
                cs =3D css_cs(cgroup_e_css(cgrp, &cpuset_cgrp_subsys));
                if (cs)

I hope Waiman seconds this -- if a feature depends on shared tree,
there's only so much that 'cpuset_v2_mode' can guarantee.

0.02=E2=82=AC,
Michal

--6lhaepxnk64h7feb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCarvBixsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhCYAD/UlpdCXDtTYtj0WFClDJv
lcSGHrDz7cPvflRpgHq9W34A/3HJN+/1r08+MxQdyj9ADbQsdLu35KqSk0v2lodW
WDgP
=nGEQ
-----END PGP SIGNATURE-----

--6lhaepxnk64h7feb--
