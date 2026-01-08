Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE73B5300
	for <sched-ext@lists.linux.dev>; Thu,  8 Jan 2026 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865151; cv=none; b=IhAOfvoVgNA+7xaIA2FMIUKhPV9Rq/AWyTVkF6dnNbjGmoEE0E7OswczFaehd7fjr96MEEVrBxbqbutUvKzNRtio4ITnTRgJzwhFEEEVkeg7debgsi/z3jMU9MowRuMFegrbESa1Gq87iqPauthHLButTQuMCOqUkdYPX45myII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865151; c=relaxed/simple;
	bh=Bq9lo2Ohtvj3XIL6dpPA64B4eaxXyOVIuYLGEY645Q8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=OK3NAv0cYfhQU4yRqJ8E4JMvfbe3t+F1dwYthewq1AwYLds2kEqliJmClm95EoXnLjbRgWYqk/0Ex/sAoqqKFx4gbnZFML7oKBG/a0TLIzili9aqRpPnyvQ8OOvuxY2T7Zv9Lu2cqDxxOmf7kyCSH/l6+Xo5u6zBETHg8fjCMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIUqVPbo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIUqVPbo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so21901235e9.3
        for <sched-ext@lists.linux.dev>; Thu, 08 Jan 2026 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767865142; x=1768469942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91O35Wu5Tt42VZKwq2kPLdWW5NTRjmE00iaWWCPrcU0=;
        b=TIUqVPbohwsr2OdWuLJgXwJovnF588ITN7/32qO8jS/ctEVlK8q4h/qlRCEj7uDtOz
         0SSbxYvTG3Tev3+ZhBh37CspZEgc0TjEmRlCZeoHN3HVGJKlmAvKUU5VCSVUUn+SchiL
         uGb6+xXOTJzR9wWo3wwrWhvDRcaLIOuhcv17Ju/a+CaW7snBfhmMjIHXgSvsE3Dw4kJy
         MWFLr+G5/5Lp+Q2Q8kVrvqfV8WzjxXBgcnKUIHk8JLYaUB0jZlza6VFApLTBVCJZ8ylT
         co1nR0BTO95kKzLypx0MSFcihCZ/oZySK4Kin56y6UMMTHG5LUtYxfoeKgL/aTiqTZd6
         7zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865142; x=1768469942;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91O35Wu5Tt42VZKwq2kPLdWW5NTRjmE00iaWWCPrcU0=;
        b=pNbthZbkq8jyQJehSI8vZhtJrSP+DfvkRBo3pWAf8CI69tynluLz6VbfetrWtKmruN
         rjgiEs+zRBjaLkN17cSa3SdQwnkQdZn4txQPMQARaSLEfh/uy7AANO3InM/dV6hCfm6Z
         dfLwAf2cmr0fNPm1xp0fHyNpndVLhilWK4V58rAuFj10NhrXWtoxNCH3zyKHRm1pNTuo
         MliyGrcCwS9MV9ck7B3m9FGx527s4n1JOAQoUtvvo7Oql9pnnnUnFKMpvHjwkbw8SFK8
         bczE8hs9XV7NvotnrC0sWj7WU9uagn/nBR18KFTlj2fPwIpvCRPR8SLQTB/EIzae6YDF
         bDWg==
X-Forwarded-Encrypted: i=1; AJvYcCUwzSoO+oT8eW6WY70SLIt1SlW2nCGxP5eDWbQWlOhuIgy9ekGrlBRVHvIySID2PD9ByntkrNR2DRQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ0ByrF1ObiQAjbAwrb7ySTSweqcrXt8TVyU/15ObRdc1+2/JH
	hCXcgOCZcbwcrMM9voVVj3O524VjZnkjPpj0ZZyNM0WFjigXDWuRjPy7
X-Gm-Gg: AY/fxX7BWqpY5l0pdeLKRiZdrjxOig8MdXHPcfSB1cRuFOA35pZjz5Ip9ux/UYXK5N4
	8J827TVN7pnwFSjd1f2M74R2t1Z5XYpdreENW57bY/HJUVQE8/saM+ZZUYhXNnhRGf6/ogG25Rw
	XrUhdpLwwacXQrDp/lmaA55QM0RxaAfyddxSK3mLwv7k5+ioPyM4dgoaQqKeuSugp7Y7CPkNrmv
	B22hcbU8wSFmJLs9hlUcXvmub7GEkreIGwSmjvRhWayhjmN6XsCyzrOW9lBY3FRKdDgpUOiZBMD
	6GnPcCvDuMDiOeFlafNmilqEIoGie9bgWQYrFNaEFI47Bw3hlehnUNf4DSwne/pej6rqvQ4NOG5
	Uv04DdnjO4v6HGcC1rI9+RdEGaLQkya5Wufs5QX3gMTuospvs7efVeaic/ZVgoyPodFuWJ/yWNM
	+MZxFt0kLTpDRnpAQeZanAaUE=
X-Google-Smtp-Source: AGHT+IE0ivurfeyw4RGMPF7H3eHa1D98hrIj7ko+VBPF2UVbcwlddpeCKfgvEgdfZlhOZHZZlhrZMQ==
X-Received: by 2002:a05:600c:3483:b0:47d:6c69:bf28 with SMTP id 5b1f17b1804b1-47d84b3476fmr69913435e9.24.1767865141446;
        Thu, 08 Jan 2026 01:39:01 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3dfasm33121615e9.2.2026.01.08.01.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:39:00 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for 6.19 0/4] Revise the EM YNL spec to be clearer
In-Reply-To: <20260108053212.642478-1-changwoo@igalia.com>
Date: Thu, 08 Jan 2026 09:38:56 +0000
Message-ID: <m27btswij3.fsf@gmail.com>
References: <20260108053212.642478-1-changwoo@igalia.com>
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

> This patch set addresses all the concerns raised at [1] to make the EM YN=
L spec
> clearer. It includes the following changes:
>
> - Fix the lint errors (1/4).=20
> - Rename em.yaml to dev-energymodel.yaml (2/4).  =E2=80=9Cdev-energymodel=
=E2=80=9D was used
>   instead of =E2=80=9Cdevice-energy-model=E2=80=9D, which was originally =
proposed [2], because
>   the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition, d=
ocs
>   strings and flags attributes were added.
> - Change cpus' type from string to u64 array of CPU ids (3/4).
> - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fetch
>   either information about a specific performance domain with do or infor=
mation
>   about all performance domains with dump.=20
>
> ChangeLog v1 -> v2:
> - Remove perf-domains in the YNL spec, as do and dump of get-perf-domains
>   share the reply format using perf-domain-attrs (4/4).
> - Add example outputs of get-perf-domains and get-perf-table for ease of
>   understanding (cover letter).

v2 looks good, thanks!

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
