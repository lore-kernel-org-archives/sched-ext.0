Received: from mail-qk2-f1.google.com (mail-qk2-f1.google.com [74.125.230.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80556E056
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965658; cv=pass; b=Mt/AWKqEUkCUBBh4/7viC0NKKdyOeMq67vJ1AflHHkzgJrOsqpzj67GQJXh4rUQOVSccbbfhNpRCAdBDCEKyiR6PZhxXww+RVHeaJthS6NvT+y3YZVZDCv0BU+rI7lLfRofy+puspIArzc9nBKn0YffN66NzhmDYlEk7g7KzYYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965658; c=relaxed/simple;
	bh=+Mkrm7KMoXH/0aW9c9AkpqwBihjracQhI+9N2aNSCYc=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYs+LkfVmQCuEy72CEA4o38QjIbDHJ+jMvgugYvIN9W0ITK3sQNHnz0nfPAv7U63g6kQ+T9PlQrkuS6Z3PuGzRuQBnU7BjQhcdeoDnUCJ2TlJEQedNx+qaOm7w9NxxQ6eYCq9SpnqTVM6UXwdE2gxy2xeJoR+e/4bb5H0ydvE9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0qqB06S; arc=pass smtp.client-ip=74.125.230.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0qqB06S"
Received: by mail-qk2-f1.google.com with SMTP id d75a77b69052e-530888e5423so13421141cf.0
        for <sched-ext@lists.linux.dev>; Wed, 09 Sep 2026 07:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788965655; cv=none;
        d=google.com; s=arc-20260327;
        b=eTbYPCtkvx+h50VQo+iQ0a61k7kZC23+QzWjaIfctcTbY9l1KStyDTbYmPQUdO2UGv
         vknJzXiba6aDldorGQOGOdlhCQpWkGrByFoHG5quRWAVWZMuF+S+e6A/MMOe/oOzQuAk
         JO0yHFTdfKIjKZZmwJWbD4DWmo6u7Yimn6hv31xSQCISQoJSJyThmJzo+O1NF7Hn3GUx
         wnusQmqIkxq/n13SWE5ng75IHlSHmpKi0o74PKneX/kB0OwD56/qRE2jqJ8WHxKxAXOb
         g+/sYJJ7C7UYf1JsNdlQC4rirb0Nys5rIFsyYtIUVOaMEXmNlH76ZTexe/8PuDAGnQCf
         DdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=+Mkrm7KMoXH/0aW9c9AkpqwBihjracQhI+9N2aNSCYc=;
        fh=vZyJSiSwNdO6JcsVR24yWjq2aHpN6m/zL+sVwa2q0dw=;
        b=NPae4BnRAgvE1wd3RWByVWDQl/qUKjJacIRBkK958LY6mvOQUan7o+oJ0JZiJlwain
         AGUxipceMUfWdDns8O5fvqBRO9v0xpkcCEmOFH3wQ8OdyYmPT2E/aG+aabLtHZo6CSKC
         kIhjmxHaCbQnFC4f2hrz0rWLyI8NpdU59zWUbZad4+q1muso7NQoiPwP8sY/sDEgb7UX
         fWHhcs0R88l8KnGWL6ZBrVmS2SfeNc2RYZkmtVPkvwO46jJ56k+bZC9xIFgWiiGHiQH+
         CqC2l5WxxM0Z1uRz9NpmXesXTzVQ2lueRdJ2FSc34JL8GYvNaJzGbLfqEUsFZ/ScoHBu
         nVrg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965655; x=1789570455; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Mkrm7KMoXH/0aW9c9AkpqwBihjracQhI+9N2aNSCYc=;
        b=E0qqB06SP9P2J9oJW4ua8hol3zcVVCBsv1QEzRhAZkSGtjfffDdCfn/RtcRIGlQ8/w
         yoEqQ0Efcorz9/dkZtpbPBUGGx7RW3suyESXeO+eSUmQpQ/i0WlhE2zCTh4FIKUuNMnZ
         +sWO+mrOp2zpBfnHzrHGtTHUN9INJ3eDO9dybDIMot8kIpCMxqCcwQM7Ec/1M24f9sMq
         eMDp487nxgVkvccH2Y+san75bW/Utr325g3AZRW70XUyP6Gxbyx1UVN0CZRUyF8xYGI/
         1HFnEOE0jvD7hYtSasCa/VnNICsDoaXO0OCyC1pdkGx4hU8y/m47S2TQAck6bPaLvFDo
         VDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965655; x=1789570455;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Mkrm7KMoXH/0aW9c9AkpqwBihjracQhI+9N2aNSCYc=;
        b=NqXHekb2I4khfs8FhvON08jxV8oJ7bdOY2l9RvhznI7vbUZSl+1cFglugetA5D+DcB
         eHSA4ucBNkfRNO+joaobdMXnmR70ykbS5MVovnp+t+xZF+q7Zn1rW616rfc2KZNYJTTB
         2JVaWDAtJo+pD4R0d925fEbyN/vB1cztY+5zSm3NoNnnB5CUU59HiD/Vc4j1Y+c71dZ3
         r+INslvrNRBroY6rr14+DxUSNbzIb6XCzjzaGZlF4oClIle5lizSmCYxns9fwKQT0/mH
         3s9hyU5/mEE3G5ik6LGD11ss5B4p9RHRz9N143omDDOZ2ul3Mp/wA7pU7IdaSzYTcxj+
         KaSg==
X-Forwarded-Encrypted: i=1; AKwUvBz6/MV1aKwmlqQ3VVR5vxTTsx4XC4lCxpeWiHTrHTVIaFLYWqEhxS29cHqN1Xuj2xDZVFNJn3+VxqQ=@lists.linux.dev
X-Gm-Message-State: AFuF++lLiUUhKrW82oJyFkIb1mj2dq5pYv4eGGCXBUQDJq2rrP5spJvq
	xA7DhGRC23/1n6KLGPpOaRbCaSVjstr1BC9iNPzNv8MyTt+hEZIXWFZNXNxegGicEbsuPdpVzHh
	1sHxKmZSbc1daT2WwJB4FModFqpA+diE=
X-Gm-Gg: AYBFou0ogkS1sVSs/iSte9aS4P7SI58t5qR67kzguWdXjynapomiQhVx0fATG7oQL51
	9m3w3fbnKtN5JgVJZGfwcCH0FJsnEZ/gcJe2dSYektVRvMKt5dQ3Nvv+0xF8BuDhIi0jQ/Ed5eq
	fEU5WmedfRaa0dIzQ5A18FJMlO3WiEdvbDbq/Y7rYxpjCxyVGtUiLl9UiUjZU+WitNveOOlLGSE
	q2Id5C/JSiGXqYo/d1O1eoqEFPnT2v0pZtqZ9pIu1nS162ScOPD/bNYjuDd2/TCaBnhwKBz6Pbf
	fOcJIdPPFJeA9hiETpoeh+nl0eLS46Ow4J9/L27dPeHssUz/D+EsT0g=
X-Received: by 2002:a05:622a:a15:b0:52f:aa6c:bc7d with SMTP id
 d75a77b69052e-530a2d00ce3mr103821661cf.28.1788965655200; Wed, 09 Sep 2026
 07:54:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 07:54:14 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 07:54:14 -0700
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Tianyi Chen <diannaaav@gmail.com>
In-Reply-To: <CACGbirQ-xfWymbY9Z440sjbUseLRuaPFT17mBAwddeN7wqVi-w@mail.gmail.com>
References: <CACGbirQ-xfWymbY9Z440sjbUseLRuaPFT17mBAwddeN7wqVi-w@mail.gmail.com>
Date: Wed, 9 Sep 2026 07:54:14 -0700
X-Gm-Features: AcwNN1V0ayDgefnocqAHfW58sB0HIvDNfLVwuHlJzZzj3we-9VRYfcaM2bKPUBQ
Message-ID: <CACGbirQQ7dZ+Jaiv218CpW38jWCCz5DUkoSAKUShstLy1GoYpA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] selftests/sched_ext: Validate select_cpu_and
 mask constraints
To: Tejun Heo <tj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tianyi Chen <diannaaav@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

Following up on your review:
https://lore.kernel.org/r/53d04980eecb0e5f6eeea25a5cf0dcf5@kernel.org

My earlier v2 submission and reply were rejected for the kernel.org and
kernel mailing-list recipients, so I have resent v2 from this address at
the start of this thread. The code is unchanged, and for-7.4 has not moved.

V2 checks the selected CPU against p->cpus_mask and uses dynamically
allocated affinity masks, growing them when sched_getaffinity() returns
EINVAL. The masks are zeroed before use, and affinity restoration and
resource cleanup are handled on failure paths.

I reproduced the fixed-size mask failure in a guest with 2048 possible
CPUs and two online CPUs. V2 passes there, including with single-CPU
affinity. Testing with CONFIG_PREEMPT_RCU and injected failure paths
also passed.

Thanks,
Tianyi
