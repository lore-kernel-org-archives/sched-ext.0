Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7C410D07
	for <sched-ext@lists.linux.dev>; Thu, 26 Feb 2026 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120562; cv=none; b=ayJVBAJUnCye+BmybErZfMHOMsRsFWzga1Wm/Dv68hV/bLuoE8M7h5cteo0EEeZ2m4HfJxBLL7RHShac9jF6XDwE+QqNwlTOPdKDnKGAyHJIWRyWb7T796jQcpSbkhk2Xq1ZGsiSQxhlUC0QQK4Ff30LjyI/5pSmWNmEav1Uxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120562; c=relaxed/simple;
	bh=XLrjsAlcAPn8bgmeYgraZaALBhUhHzDOlAnT+O4Msi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciAp/Bd8EAj8vp9b3uCiyBXVBC041BZ1tfW56w2oHW/TcVndU+micpM0XHYuYtkw6df4JK3iWJZlE5RVKGVtKXQsSEMkysQikcViIhnF8ahV0aratp7wML/mjFQjHs/Et0+5EvF0TaXMP04HgDCQndLAe2GSEXeeyZCtaroYnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+IpGs65; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+IpGs65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772120560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f0OUF3CLsanKAY3ZZyBsRNqIRW+r0UpA/BjJW9RCyhQ=;
	b=X+IpGs65VlN/OJJTuBlX8wnQLkF2M7hRHbrTpzej0+DhLkWJ2VY4Dr4hmkK8Q9mwNkdJSh
	xkUjS1tMo6AtaN+qLXQGYe9g34ZdOJVxeD8qgURMB/fkUcx5nwl6mtqpc7YtmVgWUZwjCb
	ipV8eHFyf8/NcTjziymaSQUl6xRAv6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-I10Mx0-DP5i2J2I3QybgwA-1; Thu, 26 Feb 2026 10:42:39 -0500
X-MC-Unique: I10Mx0-DP5i2J2I3QybgwA-1
X-Mimecast-MFC-AGG-ID: I10Mx0-DP5i2J2I3QybgwA_1772120558
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so16564305e9.3
        for <sched-ext@lists.linux.dev>; Thu, 26 Feb 2026 07:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120558; x=1772725358;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0OUF3CLsanKAY3ZZyBsRNqIRW+r0UpA/BjJW9RCyhQ=;
        b=YyZR6lbGqax0ioRPYTCaLsF+3ObZNahPO3M5wCfWVaMkh0G+O0ufFqukXcvCLc3qnq
         vOWFS9BJTi9xSijoEA0WtRF+W+RoTKPWXOldKmQUqG7EBB/pHf0K9fJVQ5WKs6X5NbKF
         tBgL693UsAr+tnEKVj9inwkhBs8ceyAtZb1xF35YCT4TccFhIxC8G5l90//w3/Lwsfow
         Tlru2wHJdgGuy8/2K736Ke4iyO/2Fo65nJ38PjZnNcgHMqrmeVANt1/bVDMsJzW7YxZy
         WDO0YPFlY2nOX0346LhqK6qr2XvgeoQQfArTuYBVaQiA6/Avw5nv8ZJDVu6R984IPVsR
         NV0g==
X-Forwarded-Encrypted: i=1; AJvYcCUfhvxByCATG7YgILel5PaVrrRws6OZlP9+31nl6M8VECvSuteTeReK6puzrNFhB5X+/d44FBMWgVI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyPeW6RHp7W22Zh7nn72Bz1m7ICxdnXboLDc6r4YI7YLD+mqXCD
	dxwclaqnlU5pvvcZqPP2lkvyliF5Xf9xStxAHhb2jQKlyTK56XYQ+GmUvtyNCS0jsjzNzgxK9Bn
	D7jeVVh0Z/fMeOr8CZ1U7thSMF5EVvNTSc90yVkDhYyy9joKfBO2bKsN7AbCFSA==
X-Gm-Gg: ATEYQzxOjgPaEuqBXV8titzDBzkbKfrHnivSkWHupzSCRu8R4uLLACPRO+mrp8vH3yZ
	Ma3OGmHnmdEZ23iGnlVr+cAlJFfyA85g6RJfJDj5dzTjknNdLz9VH+UWhpyGRIKx3P4ZCvs06lk
	Mx+TmejElnhBnpoFE4+S5Z+ONtos04SQ+0ojSejBbEyKZ47BWKSqhmQB7Azcw/GnQZdcd9amjo+
	DzGbJ1hXPdn47aZFMTOQkv9or03OsUA97/WWAJvs9s8vcXUaTEX2o1fl1bMWQV5Uhms26g2mTm5
	Ojf5JPnn/a+vRr+HkfcpdnsMfLSk7BDSOzD7M31MgUmCd4xdQeQPb/juSHeuUHCptHi6zq/LahJ
	a+A/Pt6PAU5r8Wg7VsnKCYOOpeXHKNmeXRKjGCmoeekUxkCeGOqGoOOAkQ9+99hMsyGzXX8dY/N
	SOoBp+RrQEo4+ZDIs=
X-Received: by 2002:a05:600c:548a:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-483c216ab3fmr81183535e9.2.1772120557641;
        Thu, 26 Feb 2026 07:42:37 -0800 (PST)
X-Received: by 2002:a05:600c:548a:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-483c216ab3fmr81182975e9.2.1772120557143;
        Thu, 26 Feb 2026 07:42:37 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b89c99sm51321425e9.15.2026.02.26.07.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:42:36 -0800 (PST)
Message-ID: <f49a6db6f0070350cb2d2b023b5733a3646996f2.camel@redhat.com>
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>,
 Nam Cao <namcao@linutronix.de>,  Juri Lelli <jlelli@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	sched-ext@lists.linux.dev, Tomas Glozar <tglozar@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 26 Feb 2026 16:42:34 +0100
In-Reply-To: <aaBlJT9Mac9KQpKL@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com>
	 <20260225095122.80683-15-gmonaco@redhat.com>
	 <aZ8snSHWw-U0lVz2@slm.duckdns.org>
	 <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com>
	 <aaBlJT9Mac9KQpKL@slm.duckdns.org>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mQhdiuGkis2a1K8jRiuGfqt8z73vQLIvzsUhEzOkl-0_1772120558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, 2026-02-26 at 05:22 -1000, Tejun Heo wrote:
> Hello,
>=20
> On Thu, Feb 26, 2026 at 08:10:52AM +0100, Gabriele Monaco wrote:
> > On Wed, 2026-02-25 at 07:08 -1000, Tejun Heo wrote:
> > > On Wed, Feb 25, 2026 at 10:51:20AM +0100, Gabriele Monaco wrote:
> > > > Export a task_is_scx_enabled() to allow quick classification by usi=
ng
> > > > the scx state SCX_TASK_ENABLED.
> > >=20
> > > This test already exists - task_on_scx(). Please feel free to move th=
at
> > > out to include/linux/sched/ext.h.
> >=20
> > I see task_on_scx() is used in what looks like some sched core hot path=
s (
> > pick_next_task() -> prio_less()), but I presume not inlining it isn't a=
 big
> > issue.
>=20
> I mean, you can always export what task_on_scx() accesses.

I'm not sure what the cleanest thing is here

task_on_scx() is
  scx_enabled() && p->sched_class =3D=3D &ext_sched_class

scx_enabled() might as well be exported (together with its static key), but=
 I'm
not sure exporting the sched_class is the right thing, since all those sche=
duler
things are quite private.

On the other hand, task_is_scx_enabled() (added in this patch) is
  scx_get_task_state(p) =3D=3D SCX_TASK_ENABLED

and scx_get_task_state() is
  (p->scx.flags & SCX_TASK_STATE_MASK) >> SCX_TASK_STATE_SHIFT

those are pretty much already exported.

If those are really equivalent, wouldn't it be simpler to export
scx_get_task_state() and use that in an exported (still inlined) version of
task_on_scx() ?

If you think exporting a sched_class is just fine I'd follow on with your
suggestion without bothering, though.

Thanks,
Gabriele

