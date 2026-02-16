Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B329A1
	for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239626; cv=none; b=HFDbi/aJ59w+yWJOF/MtEzpoAUt6tgOMgAM80abO6QqDYPTPWfrlnCMbDJrb68LlDVjntKrAHg7mzIKNtYZJUq9tRiQCtjlzVtMdD/4FXPfZkzby4EV1jM4TFY7AWab5hcbAOQvZ/MswBAGVeQhgKI/mSSGL7Wxkejq7wStMsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239626; c=relaxed/simple;
	bh=f6jANwf+3VC6981lhUK7QpW+khp0gVkS4LX8H2lYnS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCe3MRZA6uhGqEdUl3/xmfvr9QBMpIaKVXRUF45Ea+73HWu8muu6FK5m09P1ttfbyMRrBh8A8Phr2sD+xZ2lo7WeGIekCjibrEu3/8m7xbTwNlmYBWB92FVYt9cYAS1PmnAFZ8bd+dFhB5GrKtXD75SFTJghq/5f2j1JJwnLdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cswuNzIs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cswuNzIs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-823081bb15fso1701644b3a.3
        for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771239625; x=1771844425; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhDvG/DUuH6mwfksBYteQLRzjfJZzwllstkirLsAhvI=;
        b=cswuNzIsJgTj9QnXGLqldtsKZUSkBneeIzJKXDQfYMb6tb2xee/14ZA8YpY5JYknTn
         IFB0rzDSqYd6O6AQwlJRebixtAd5+iDh4iEsxQxaUinDwUL8x3ziHie66HimciyDmSqu
         RqIf8j1EAXUvwBICZkwNQ2JvIhXk1gdmtPtBHFdqLUFab8ut+kygD+eID9zYSV7UGIRO
         daTGPFkT5Dk2eeHxPmXaQDOdPrUvtT2RIiJuY+CUREIE6L/ulOtacZ7MhZwrB9gwMMsq
         P49HvrCoWjdtsVqYLb90jPnKrrkZ4EiIGHxU05EZ3K4vO6QqPLvDKAqYb7OE/btQ97HS
         7ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771239625; x=1771844425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhDvG/DUuH6mwfksBYteQLRzjfJZzwllstkirLsAhvI=;
        b=PGo5r2/lXgDQsiGKhahgC7KZzEK3Qa57h5SH6YNXKENQZlgrOSC5CzGbmXrCjXKC48
         HpHolCR86kXOFB+Gq6uX3OEYG9jEMQtTVe24kHKtM6DVRUBokausE4Czw0/q4ulMFFt9
         N3R6bbpmUQrBVedcQXmRZQTGdMqu0JfNstflwGLEhPO7BxoqdrRdAjxka8W52qhQP5DD
         HT7VoRdg98Kmu41HyuJ7pjkg7UpG++WyjeHsxyuOu8/0M5odch+Jmo0+zIZNyfTLXuBd
         QsEG2WIIfXcguZJy663pxXQvMQ1H/1P7J0yd7EuBP6T+5e/c2YwxZTGmhtePIC8J4hXq
         /GXw==
X-Gm-Message-State: AOJu0Yz/sKOapd/ZoTbXbiTYV9fSskkwFn9gMhZxoHTfqHu/dWeF5DLl
	pWso+7b+y7vklJ/6R3X1kYVxJnjRtou8ViUB05DQhVLT6yLjuHz6evJJPAiTng==
X-Gm-Gg: AZuq6aJ3im3mG8WsKAshf+RXSVbN2s9TzALzB2gFd65rzV2GmdHZFuF5Y4nmF6qmE1Z
	W66PgyD+bm3CuJHuq5ICSwh1VlfT30AQOscy8XEj9wEAvWvWDjqIMsfM1528QpW3l0L+6um1m0P
	pMaoRLHsU0OyIwBkGMg0lufaU7netSLuvF3M5YZUtxspBEekqrJ34dQDkHlhYgTGtfdf3ZQKrZo
	D+iKMNFJepeH7oq0PycqU0FPW5yOHfb5/4wpBwsL0PsXC/lrdpou+S2Rn7NZd4HF7db8Ok9cy1O
	Eo/qNXicrh5Kco+0lxyMr72lJdCYUdlQRtgwWCNl0VQkhFOC0kes5cE2fPOe0IU10Dt3rlczTVu
	VoNx/QR6SKpD/6U7251xzJdS1oPY5H1GhsVkC8dqC1oyBBYSeZ/nNecIXmCjrTdma/oDPhY8s6n
	WfamvBBhvt8RlDMMIsY++qhwz8VFZiGKZB7bzN+3U8jELSNJzU9Nem
X-Received: by 2002:a05:6a00:3919:b0:81f:15b2:21ea with SMTP id d2e1a72fcca58-824d95faaedmr6142223b3a.42.1771239623344;
        Mon, 16 Feb 2026 03:00:23 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:87b9:1690:2f70:403c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb5596sm9978994b3a.58.2026.02.16.03.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 03:00:23 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/2] tools/sched_ext: Sync README.md Kconfig with upstream scx
Date: Mon, 16 Feb 2026 19:00:13 +0800
Message-ID: <20260216110014.771335-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260216110014.771335-1-yphbchou0911@gmail.com>
References: <20260216110014.771335-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync the documentation with the upstream scx repository to
reflect the current recommended configuration.

Ref: https://github.com/sched-ext/scx/blob/main/README.md#build--install

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/README.md | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 16a42e4060f6..bcd2c49d777c 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -54,19 +54,12 @@ Kconfig options:
 
 ```
 CONFIG_BPF=y
-CONFIG_SCHED_CLASS_EXT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_BPF_JIT=y
 CONFIG_DEBUG_INFO_BTF=y
-```
-
-It's also recommended that you also include the following Kconfig options:
-
-```
 CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_JIT_DEFAULT_ON=y
-CONFIG_PAHOLE_HAS_SPLIT_BTF=y
-CONFIG_PAHOLE_HAS_BTF_TAG=y
+CONFIG_SCHED_CLASS_EXT=y
 ```
 
 There is a `Kconfig` file in this directory whose contents you can append to
-- 
2.48.1

