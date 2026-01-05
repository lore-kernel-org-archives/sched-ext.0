Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AE330B25
	for <sched-ext@lists.linux.dev>; Mon,  5 Jan 2026 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612453; cv=none; b=gzVkM1wv7saGiYltBwhOgt0Ko79JWKVcEP0yjUqfR4xq7Ijvc7EwjjyydO5UQyLywaATLzUsNPMmBtVWLov+DUUXGV65ySdRMUMhJXQM9pL3AQVpzKRNNj4PiUKRWLyrhF0tRlr2SSJMTzqoDR/R5tT8eYbrVsNhJpgu7OcT2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612453; c=relaxed/simple;
	bh=Go+GAYzO0jgTKcc48Myrg2Pj0BaCXr+2m/+CGE76n6c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qUaiS/cuPdzhzzhqAtjYW1FdNiUJIbO1lxLe8XYBrFsjNOLyBanmgLqKZ7aVtDeOTyBOMs6J5Zv13QWFGXluhtUjyKC7sJqTwGloQQXEWjVaRLZlYy300OIcAPmdyK5xOGZkWbOVFWYevfKeDYiXPpkP81Pt5LWQMov7CIJJFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSU23xgD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSU23xgD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so11106976f8f.2
        for <sched-ext@lists.linux.dev>; Mon, 05 Jan 2026 03:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612447; x=1768217247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j95TD1ZmtU4Apnwzg09U0kNwpICIT3BxQAw/HHzh+18=;
        b=QSU23xgD4EidthXXF9/R8xbkKMAJFez89/04p8+RJCm1VGSnLpquMOlqnR0x1BuAuj
         yu6enklF86sSaWrlQVyt8jKC5Y7jrM6GBNu1hnd8vX9f8AqWILykaeTi4vivlioHebSK
         7ihs1jIsyLA+HzSXun8rwARBhtH3YbFSYblvN2v9bl9yeDR3L55OiRWEKlqBkr5YcpWz
         GjPjmSZhUHt+3/NVoBKRIdLfUuZHNLJ/+Jqn0j36XUPdkr7CHF9mYOUhMFsANJv04WrV
         zHq/ZiYWkFPa19jk8z7S94ztZPRQOIC73Tck+0SttTB0RnbQVphUdHxtYqUzLRvMGMXl
         CMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612447; x=1768217247;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j95TD1ZmtU4Apnwzg09U0kNwpICIT3BxQAw/HHzh+18=;
        b=fTw0S66Mg00HG2z/Y0hEbNq99sj4QsCKc1wRdIxA7elEJ0+BQbMMzi/O4rCF0fnWmE
         S1jMXUtd3Va+/lJAeu/KXcSwSxCLVQvxcffqbmvl147LnHyAuosUsJdHw39f+ie9K6w/
         BgA+i3Rl+orGspPnDXuzbYUXU1pIdxoYOgcwX1caWGlc/Vb7FE93ZfpaYcInFR2DhzRD
         c2HK4ozx0nsU3Hvb4nvZAxjZ4rK4UlX1niOR6y26i/N57NuLq9+trEcY8JA1OCUd3drU
         2zbJBD1u+HW5/HBb0yjgnaiQuk+/x8yfxpW00yhHWhJW5UvoOFGLPlQMVDqm4ODkM1fI
         hXlA==
X-Forwarded-Encrypted: i=1; AJvYcCWIWNd7B5tHwj6NHSY0y6jIYjhuR4FRh2OiVAFS555tJxPADyWZBWT5f0iIgFhsIguBzcrgiei6p0s=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6FAkBa2DqqsaWQdDb09cTNoG4BU5jn6gfMafbXCZqmhxh+Kqm
	oZtE8rOwGRyJnSI27jbkgni5nAGmEwHC5YvwL89nUDt432qXxv4g/zj2
X-Gm-Gg: AY/fxX56r1Npdw4ys/JJCYqdNrnNZYSWQT/xfa6RAnP8qMjMmIdNrV8PEE+zN71IAK1
	xDvbPRYR5VNVkYJ+K2EvYgc4YQ8o5vrFE7kLbBXQXdH+cvRf/qa8MrOp2/R3/Xcb0u1S+kflL9+
	ac+LoO85KwL4Tqw4Bwpgq45vvNLfsAgZS7DODZrp0idKTC5KsZi1/cJzp4Jk8ZxrsR2FlTu2aXj
	J42jhzjKCYL2K1SATw5dYtDS3MOnxWxZRw+R2c7ttd9V3DRXBIHFWjoRxA9dHZ6Qf+ygYdERf/x
	dP3zAHu1xHgw9Q5T9sHw7NXxteJdu3hcNY3amGUC2rphJcUIOdCRBnZvINwhiuQos0sxzyqUDZZ
	mfY8b+t6FSLiYradlIGur53bZ+nYrS97u5PvhBuRFmz3duRtbjlR+NpjK7kOPMBNVCGLYu6J9+A
	cKEhPX5qqICQFgqTu9Jtd3OLx6Y7k+EH9zPQ==
X-Google-Smtp-Source: AGHT+IHKBRGJ6Q+jIIfyxjpoPEvNxTxw0yHBFy5IfbUyV2HSAIYXiI1jCB0lNf27X4mjsLq2EPc8PA==
X-Received: by 2002:a05:6000:178e:b0:430:f7dc:7e96 with SMTP id ffacd0b85a97d-4324e50d6ccmr65245024f8f.48.1767612446482;
        Mon, 05 Jan 2026 03:27:26 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830f3sm99180248f8f.22.2026.01.05.03.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:25 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 2/4] PM: EM: Rename em.yaml to
 dev-energymodel.yaml
In-Reply-To: <20251225040104.982704-3-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:25:09 +0000
Message-ID: <m2344ki9nu.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-3-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Changwoo Min <changwoo@igalia.com> writes:

> The EM YNL specification used many acronyms, including =E2=80=98em=E2=80=
=99, =E2=80=98pd=E2=80=99,
> =E2=80=98ps=E2=80=99, etc. While the acronyms are short and convenient, t=
hey could be
> confusing. So, let=E2=80=99s spell them out to be more specific. The foll=
owing
> changes were made in the spec. Note that the protocol name cannot exceed
> GENL_NAMSIZ (16).
>
>   em           -> dev-energymodel
>   pds          -> perf-domains
>   pd           -> perf-domain
>   pd-id        -> perf-domain-id
>   pd-table     -> perf-table
>   ps           -> perf-state
>   get-pds      -> get-perf-domains
>   get-pd-table -> get-perf-table
>   pd-created   -> perf-domain-created
>   pd-updated   -> perf-domain-updated
>   pd-deleted   -> perf-domain-deleted
>
> In addition. doc strings were added to the spec. based on the comments in
> energy_model.h. Two flag attributes (perf-state-flags and
> perf-domain-flags) were added for easily interpreting the bit flags.
>
> Finally, the autogenerated files and em_netlink.c were updated accordingly
> to reflect the name changes.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../netlink/specs/dev-energymodel.yaml        | 175 ++++++++++++++++++
>  Documentation/netlink/specs/em.yaml           | 116 ------------
>  MAINTAINERS                                   |   8 +-

YNL spec and MAINTAINERS

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

>  include/uapi/linux/dev_energymodel.h          |  89 +++++++++
>  include/uapi/linux/energy_model.h             |  63 -------
>  kernel/power/em_netlink.c                     | 135 ++++++++------
>  kernel/power/em_netlink_autogen.c             |  44 ++---
>  kernel/power/em_netlink_autogen.h             |  20 +-
>  8 files changed, 384 insertions(+), 266 deletions(-)
>  create mode 100644 Documentation/netlink/specs/dev-energymodel.yaml
>  delete mode 100644 Documentation/netlink/specs/em.yaml
>  create mode 100644 include/uapi/linux/dev_energymodel.h
>  delete mode 100644 include/uapi/linux/energy_model.h
