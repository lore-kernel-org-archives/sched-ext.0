Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6942FD696
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806011; cv=none; b=JA4akmMYR3yD0Tr7GAl4dN5bE2TY2xkz9VRn4aPAlbLZy+c15aQleCjpfE39RdDGdKsEGZvzhad1f8nY4TZwdmKXYwh1uW6ieudLzfGuoqwJy4h+BcPbncuvfGchfGeimTABj73bqWk1xofYOwLKrn4JvKVEM9xmK5vRi5tb25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806011; c=relaxed/simple;
	bh=sdDGYrHeAWacIUyfKNMp+p7ytNhIh+eztoO0wVn8KQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5CJ8YvzkVAGlfuR5Am5GMWXu4ct8YWVpa2WgHm1p/Eq7nCC9EHuIjdipYnz9glTvdc5sd4uk7l4DJPbp0GgF7n9lJAkBgDrVy1VyuwMYRzW01L+IxJeyguU13N6Q+OrH45RyHKjuxP+4O76wFyryuHtIHTcCfLQrL0Eea8++q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSBzFowt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSBzFowt"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35990245493so3489626a91.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 06:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772806010; x=1773410810; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk0hhHCfbKxfhVzW+kzXBAaDl6vDlZoTgh4BXmvqu64=;
        b=bSBzFowtIuoGbXQlzGBBHsWcixmA2BeGawQdffKkBd/vOU0OI1/jj7lYsmKu1+4uDt
         WZp+So3OXAUVAEwQhalLJD8Zq6HBb8Kb8Bug765hnStapkbXe5Npi7jll0tsXUu4O4fJ
         c/SgkFfoFaJQmVBQBSzjNZAEep4O5aD9MoGf88gkGqCoCDnQg9tmQA9FYD51aNa8lJpR
         UZWG6L0vXiBVkrBeOC6KyRpHDXMpr60/pOcwvlhR/sGhft4pJSX/81sindXtQiSiX+zl
         D7nqp6PWkFoVlBl5nfme4DA6q1wyLpfzVGj3A+bEjOVOczCyXEn+bxjcZjDjS2mKnjrM
         tclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772806010; x=1773410810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pk0hhHCfbKxfhVzW+kzXBAaDl6vDlZoTgh4BXmvqu64=;
        b=pXsEIAE3ZbFJx3OmclU0uZV/+CRmVZ2qXBGsu9wJ/9ICUr8XFxyqzRFg+1R/jws33r
         VEks/ax0PssljinUrLh3jSr4EpMHfR4H1E1iq0SbXBWNJBhSc74Tt/qzpfVoGMUjR3hU
         scXsz/tE2Dexy1jaTkqTQRMPJLSMBI/vLTMGAVEI0OJqWS0aeo3gE5gBZX+Zil68F0xj
         suKZ/rqjp7kLva/NA4Bl6CEYwVVEZNq7oGW9yZRb5qQcYWU/kaRGaNGNQC9IXCsSlsFG
         tL4f7U3UcEfVrnUkMv/CZvNYhErD1JaLRMWFW8zDvAX6/5YzJs/V4K1B0eMmeqQ8swCW
         HGdw==
X-Forwarded-Encrypted: i=1; AJvYcCVyLflJKFzAFwmURBDJccmZ+ibPBPgAo2lzOOiEPoeUU33nCVzJR68mKTguAjPMCskIMMHquXFy6C4=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp1gf+/1xZkyQnfO39QzVGrPIla4yOKAK8ngBzZy0wHs/hOfdd
	fzkeG5fiRcvOHo4y577V0E58rGEMfrheLA8t7EkTXTw+f79pR4Y4KuLc
X-Gm-Gg: ATEYQzxrpSXX14fHeqqG5/CJh7ykSk2z7zCVTZBMubDYFkAYYaJIie+H+Q4LPOwKW1a
	X3HrqCvOnBtgdAUyS1pgBewlTfgXlvbk7/1CMMh40gIX1Eyqb76rav9tXZyMk6Zqp34T9+G1zGZ
	s2JhUw11VB0rX5rv2owecIJBBLUAE0XMgK/TPszFuAD7qgiWiR7M2iGJHypZpYJrkRXPELPce+t
	RIdymRpfaCr0eEskdZLXHgtGuw/n+1rCbKdzpnd4Wz3EsdvdiVeKCOhX2x1g/dkvRrS2O/SjVb/
	P+JxSN7IjC3bVjhEmk3RWHk2/ObPty00ClHkD7XfzrKsQxVqKuoz3fPZMcoUf2PlM+Qk+Nqb2+a
	wpkAsuPWdMLkhN5rTppTvxQg+BLgI9jRXZ4XAZEq4iKBzjaiPbIKlgpCaIjhOHgY8aGB2VYt5SK
	Fr+S2bb3lhnPoTyQJwSlNVXKYxMt7IUEzhpUI0H0IOgheRIeTXGoDbdWtTaWxceudzI6o7R2/le
	dU=
X-Received: by 2002:a17:90b:33c4:b0:359:806c:7a94 with SMTP id 98e67ed59e1d1-359be233997mr2133785a91.7.1772806009846;
        Fri, 06 Mar 2026 06:06:49 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d60767sm5380734a91.8.2026.03.06.06.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:06:49 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: arighi@nvidia.com
Cc: tj@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	linux-kselftest@vger.kernel.org,
	Su Zhidao <suzhidao@xiaomi.com>
Subject: Re: [PATCH 1/5] sched_ext: Remove deprecated SCX_OPS_HAS_CGROUP_WEIGHT flag
Date: Fri,  6 Mar 2026 22:06:44 +0800
Message-ID: <20260306-reply-andrea-bypass@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aareTeuAos9-Mg2c@gpd4>
References: <aareTeuAos9-Mg2c@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

From: Su Zhidao <suzhidao@xiaomi.com>

On Fri, Mar 06, 2026 at 03:01:49PM +0100, Andrea Righi wrote:
> Please, when sending multiple patches, group them together in the same
> email thread with cover letter email, otherwise it's very unpractical to
> apply and review them.
>
> See Documentation/process/submitting-patches.rst.

Thanks for the feedback. Apologies for the inconvenience.

I resent the series as a proper patch thread with cover letter:

  Subject: [PATCH 0/5] sched_ext: bypass state machine cleanup and selftest
  Message-ID: <20260306140325.2710927-1-suzhidao@xiaomi.com>

Sorry for the noise.

-- 
Su Zhidao
