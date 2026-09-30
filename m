Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B24CDDE3
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769086; cv=none; b=M8zgfcaJ536QihtHPrhoDN4g6tolJwy6oerv9yTmaeZdCAKgRFJw/9VpdUqpWSTVAkybpSg8kpC05m0gocmSiwR3Fvh5tmAfusfPhtbBWwmdUobcInzMybQBqBfueNurdIJXODOY0LqrWR1ImyXzsLdeFcUec4SrQm4qki/s6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769086; c=relaxed/simple;
	bh=IjTyxTrv1hw/bnkX4tx6voGbC6c0oHZEI64S3pOOJE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=daWY++Q3eJqXLROX8MF5dCSDvg+yajAiJRqE93WtSC+CKAP8mCmd5+SkIU5picmTJ619voM2ui11DAkCqoFX2Q0m2v7i9h/Erbd4CGf6kilGpPZpSOC24XsP7CJdtDFeVUy0vWoyhR5AIIylDOh8NGKiM3/xc0BJ6yMkZZJGO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuncPU1K; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuncPU1K"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e661c6440so37292735e9.3
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790769083; x=1791373883; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjTyxTrv1hw/bnkX4tx6voGbC6c0oHZEI64S3pOOJE8=;
        b=MuncPU1KbeRqcW1uxy5afrazvx/H6L1B2I64G6Dbcfl4YOKrThznasgzzCLJHLqHXF
         MDhASUIHXQytvXV72YH4JkCMrNY9WaEgqpOvV8JM4vMaC0Ve0i9LAN6dj3GnETI10q7M
         ABoN6b5m1t23N70Q/naJ2t/xI5LsnSBiJre791/rfrv6lCsHO+opu0BpO1kKqwNvpOz8
         Z542dhEmjabHiD55P6zMrSngZCAs9U6urj+zg/XBYClTwle6shinLgCjGHWSQlzbjyoH
         XFc9fYasQC8Q9wgIz2N57bjIH/LH+EyULntNcDxe9UZfhXMjUdRrN0XWxXJXtJctI1Ow
         HmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769083; x=1791373883;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjTyxTrv1hw/bnkX4tx6voGbC6c0oHZEI64S3pOOJE8=;
        b=0znoqCygiZiSTCuoQSWLXCMcn7wp50vcJvPszhd9FSPySyVcoULfsW4GxqbTjso0Wd
         oNGxATkkh8LxlpjwvFCQlnh2m6Gubk9ez0Q2+Yw7Waq8AjAN6/GALfxeGluogW+2fI0f
         OaWoEGTDW+bbs7lIROArPWg/iXRvVWbUDpoyajSSdqCstpvutZUqvQWHb0S/X63Lwv7C
         Xs1WpNgekh6tShA4Nt8pkRSm+Ss7F1Lsj21UdnvuYLAFyZC2pCNUPKYYp2luLbxKMrCD
         AsSrpanCOw+yK++n/N+WI8ohHc9YF2UTaBDQ7cTu7KgrXHY5rnK1hakHsHgKypCJ8PQM
         8ORA==
X-Forwarded-Encrypted: i=1; AKwUvBzadwG6tAkbhWUwwFgP1DtRQ43ZpfvwyZ6I7kEGpD3uBkW/j7FXSIcPJsN0eG1GMhlNSIq9hvhSB3s=@lists.linux.dev
X-Gm-Message-State: AFuF++nt0MyMIcy7sSdnZ5WNv5476iOnB/JEbq+i/TSOSl+IyxQAu4EJ
	CRPxwNWIQjqNHmuzneJayv7FZwDs/JWR9oFYUWEfqpJNpNYM882VE35KD/DTVtQWV7UW4SbMrtl
	NxnN3Ty7eOZA/SA==
X-Received: from wmpj7.prod.google.com ([2002:a05:600c:4887:b0:4a0:780:757])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a45:b0:49e:6861:50f7 with SMTP id 5b1f17b1804b1-4a01afe1e1cmr17756805e9.5.1790769082836;
 Wed, 30 Sep 2026 04:51:22 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:50:42 +0000
In-Reply-To: <20260929162803.B33D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929161730.185271-2-jpiecuch@google.com> <20260929162803.B33D01F000FF@smtp.kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930115044.337291-4-jpiecuch@google.com>
Subject: Re: [PATCH 1/3] selftests/sched_ext: Add a test for ops.dequeue() on
 remote local DSQ moves
From: Kuba Piecuch <jpiecuch@google.com>
To: sashiko-bot@kernel.org
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 29, 2026 at 04:28:03PM +0000, sashiko-bot@kernel.org wrote:
> Could the test be updated to use a goto cleanup path, or perhaps assign the
> link to the skeleton so it is destroyed automatically, ensuring it doesn't
> block subsequent tests on error?

Good catch. In v2, run_scenario() always destroys the link once it's
attached. If fork() or waitpid() fails, it also kills and reaps the
workers it has already forked.

Thanks,
Kuba
