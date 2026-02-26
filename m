Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011C37418C
	for <sched-ext@lists.linux.dev>; Thu, 26 Feb 2026 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089860; cv=none; b=pQYV6yPzj5gTf3q1DX2G6MvicdrLX/B3sC4UJVddhX7FZAo6ahV1gctSoqzx/1vIuCRD/jTm1YqM0oG3I32Nx1bWcHNEO3t6z+GaOndTQ4xa8ti55eHtp54PilXIZeK8j73e+K1YhoKE2AdrxRpUUagha275jeEDr3raJ27y/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089860; c=relaxed/simple;
	bh=krIXEowH17NJHRuO/jHDILvAfk2uCYZj8/qtCx7rZHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhUnzTkvIF6XdCjwH7mwZTqedfWlP/tuKCq3phmdk6TAvf+QryGQOgHZfsmINtPoErklT9ts6d3+cfc1YCxqZaOXP78xKUHGkR5nC4IFyZ8cFUx6iztSihk2sHcSmcLnRMGvUWXMy+CPBzZ1+l7n8zQ4UpV+kIuDUNrvc4705oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBsad0Qr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBsad0Qr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772089858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=krIXEowH17NJHRuO/jHDILvAfk2uCYZj8/qtCx7rZHc=;
	b=LBsad0QrTlFY7HNwJe/aDUlsWTvIHItb+QeoJYXHpJRkr6DQ1NRZViGM7r8QLN8wckUMUj
	aLfwuaqrB21fhe8AAuEYlxmpYKYfPf6n3A1DXmTxw1J88bwOKdEv9eQcbWwAJqgTvCra3i
	nQU71ISWAGJdHKE15qNbeKmRwffsOw0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-UWKjxUiPMzCBxqfxAWfeMA-1; Thu, 26 Feb 2026 02:10:57 -0500
X-MC-Unique: UWKjxUiPMzCBxqfxAWfeMA-1
X-Mimecast-MFC-AGG-ID: UWKjxUiPMzCBxqfxAWfeMA_1772089856
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso4486745e9.0
        for <sched-ext@lists.linux.dev>; Wed, 25 Feb 2026 23:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089856; x=1772694656;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krIXEowH17NJHRuO/jHDILvAfk2uCYZj8/qtCx7rZHc=;
        b=fv3GtRWzZSqp39IgVdaBYc5qBi0/IiRvpCi8jxfYjsl7mgg13XdpMgOrtIr/o/1STf
         JT7AZ1oKCszRtWkknf8kF23ZOHD4QBjSARjHxgAog+JCURqPtKrk9h3TuhVZCNoeVTO2
         DBoxLkt/qOa/q4ODR41yT+ymCFfFZMUg6YSdsW5LFqxgNKLRxM6nW8rS5rQpx1GK38kP
         wpFjQZg6FUnrPyO8y5Ve1dRZEHGd3FVeUdOAseQ4vAlDl8KKXI7QGYhaoMapZtzZwh/E
         q9zMnnmN6kH6PFInYB30cprYTec4mOJV4sN3DHj+rbhm3nmm44yfpJWlPhLsTJCeaCzi
         N8yA==
X-Forwarded-Encrypted: i=1; AJvYcCXjQyloguPFZzPqZRAEUxNw1ZPUVRNChCQIYncHO2LiIqJ2hbPyM+8eUaMrLbY8wiC5JeokmBq4ATo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0MZyfMH+GbbUowAGnNMrwY1BbodMM2WrSxEYtHwEPywB3Jv4t
	SO6X2t7LIAcSq8/3She7ap9kVQXzfOR972o0yTrZoJy5Q+uswor8cCN+8Z+tJDwSHL8ce0eD10/
	fpNx8TMB9ooPboKOBDfaE39ZFr4aZ4wTZ44shWgv7521Li+j/wnksTINvu998ZQ==
X-Gm-Gg: ATEYQzyCGQi0EnJyoGQ1fe1Am+E3LEymhxno2lp0nlBMBENchTlOULVIs8vVrFvTEdC
	Q+IN8CCcQfkkxtx6CKbH8kL38cJYg2nmi99Qku6AoL+nF5aapJx4y1aIjDymDltnrafj18h91m7
	mTHQrf3iYXyEiHvhAAqTuAN4hxJeT9vpT3ooTaRKNakVGWTA6KftarX+yLncfurOJvr7KEXj+/O
	JWWDC9S2OOpcGNsKL6dCJKDnSzuk/hxABWLCgXXVKN4JerlWXyw6kpaFlBPTcMKrSXZxfslkmw+
	zYBgagejRlndkgyGYmbFeMSO1a3uXHhE317D2dUkXeCWHSN5BlhJTttFYQD54CF+b6IHih7wcXJ
	gNjQrH9dUgFeCsZ545DU8pSdGGyGdB67jUglhF3x1mdridcUdah1t9oQeLr8uMkN6a2XIgk1MTE
	M0g5bNH7QZV/gVWv0=
X-Received: by 2002:a05:600c:1411:b0:483:acd9:bd18 with SMTP id 5b1f17b1804b1-483acd9be44mr200825625e9.1.1772089855792;
        Wed, 25 Feb 2026 23:10:55 -0800 (PST)
X-Received: by 2002:a05:600c:1411:b0:483:acd9:bd18 with SMTP id 5b1f17b1804b1-483acd9be44mr200825285e9.1.1772089855392;
        Wed, 25 Feb 2026 23:10:55 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770c2sm23532555e9.10.2026.02.25.23.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:10:54 -0800 (PST)
Message-ID: <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com>
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
Date: Thu, 26 Feb 2026 08:10:52 +0100
In-Reply-To: <aZ8snSHWw-U0lVz2@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com>
	 <20260225095122.80683-15-gmonaco@redhat.com>
	 <aZ8snSHWw-U0lVz2@slm.duckdns.org>
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
X-Mimecast-MFC-PROC-ID: giWa-umO73Sonif58LO3d_ckoORwazKnO2mTySarXU4_1772089856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-25 at 07:08 -1000, Tejun Heo wrote:
> On Wed, Feb 25, 2026 at 10:51:20AM +0100, Gabriele Monaco wrote:
> > When a sched_ext scheduler is loaded, depending on the configuration, i=
t
> > can handle also fair tasks, however it isn't trivial to understand if a
> > certain task is currently handled by fair or ext outside of scheduler
> > code. This can be a problem when writing verification or observability
> > tools like RV monitors.
> >=20
> > Export a task_is_scx_enabled() to allow quick classification by using
> > the scx state SCX_TASK_ENABLED.
>=20
> This test already exists - task_on_scx(). Please feel free to move that o=
ut
> to include/linux/sched/ext.h.

Mmh, right, thanks for the pointer!

I see task_on_scx() is used in what looks like some sched core hot paths (
pick_next_task() -> prio_less()), but I presume not inlining it isn't a big
issue.

Thanks,
Gabriele

