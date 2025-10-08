Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A529B229
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759889524; cv=none; b=jfmXejPeQ7WTYvDcXxxAJBS7k37/ekOTUHoTYx7gqvAEhCsLR+Eblz2h69tmVBnpMhDX11TRHK+NP68bUNGEJ7dmkqDWbf5ecxyVUtbH1rn+7HXbfbuMJc7GUAuIXgizM7AkqwyXagqluEn2QDfDcjf32PaW02LqkKtRK65hupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759889524; c=relaxed/simple;
	bh=J3zMhXU0CzOWpbVDm1VW6EdK/QN2flKoygDN2tmdj4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8iNKKO2il3Xi6d+DQ+FMiRlhwe4/BLUdOT5Mz4oqv/0TQFGCK3SGYRkAHXddTuxPnOz9/3E1PhGl+ajhxqpSb5fP1MSAjKdM/2n2iwqcksVySsQIMjV1x/uByb5COpvlVhjgYkwbe5rnslzoI5faKM3qN9b1Rpc3wQLvi1drVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqpqpnC2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqpqpnC2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2698384978dso49994705ad.0
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 19:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759889522; x=1760494322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QdhCz/LHAaQk2hiuK6Em6SkG+DuB6O3nhZrmrilNP0=;
        b=hqpqpnC2U4VizZjtrAgztpoaGIsnoeN89kNItUb839OBI91OJQ2gSjCBjD8CGkasUc
         eus11LbG6nq5pjuKJ4QjL2cltLn1p2xHXDjF0XkIRf+qabORCj0V8P0+iGMQFk7fBzE8
         i6ODbhR+W/47KBTxu+Lah8WrO4Z+m7YuUiRmGH/pTvYuRicaxIUufW9UbRJnas9Pwik9
         cEz5Y8D1oAY1BxvH56WZY0bBKtbAgdDX3zXoGVZi0+epOLxa2Lg0G6fIYOn/XKsy59mA
         bq8GGNtT7K+oOy5SaXtCw0l24Q+CUcaTl+jA+tsrgGx/tNRzM9vZ02tmVsVoWVo/DisT
         VE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759889522; x=1760494322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QdhCz/LHAaQk2hiuK6Em6SkG+DuB6O3nhZrmrilNP0=;
        b=nfZtCOK7RllSHKcBy2IwWejy/M+rKQcIJFgnDQdBAQO0WHUv+0aJFBU2kPDgMzU/bN
         0R9EShUoFA1JH1retA1/LJq+H1iF1aS0Ie4wUFbBRwhn+42MNAg2SnDWYmTAQrRSkOPv
         f94G4nmRUmHrCHUp9zwDD972E7VJQAyf7I/sroLAa/t5f6oS+U/A3vTyoqS5vtThIc5B
         PxylY4NLm5LoziYVWpywQRjjjj++qXafadTDKnMLmaCfJKQzVr2Bk7T2bR3ggetmv3eM
         SFNCtBTeO4Oo3rYLlvuqJzCbokecY/i58Kt3cdXO7ycGSUfKpIz9b2IcRJzooUIcQU18
         6WBg==
X-Gm-Message-State: AOJu0Yz08+SCUlqWo+3wKTy31GBc+2pczKr24iSGlENQSgbS9xsbtfFW
	mN4j2fS8A43BC9lhX9+4p9tfgIvfeMTtRFvpLueGygu2NzyoqQREMwTy
X-Gm-Gg: ASbGncs0YEaFQMUlJ9FBcH0YPGnTw0BtaPTkWV+98sbq+Ru5DbeJwJThK9IktAWMR/H
	J93U6j7iUkJ1lSaOcSG7vnj66f5UaBqkvXfLnFaJQPQU3lqaYfNk+zxZP6qOVdlbiWi1E/wOo4U
	fPV+avx0/KsW0a7A710zVIH5pTxUx4r2k2I/cBhXQnfSDIKtvEaSn6hR6RqbUA+06kg2ayS8ASj
	+W3OHorG99+Wz0hMhzDSIcrOSJwhRfnwSx8M6noMnYS2j+jFjQlY8OIwKeYZoHdlSc/n3sPomd6
	NIomHzxu/J2P0jGTpmKW5dYgbxOZT8qrJiXVA4Fwpz+FSKYGzGKSlE6XQNPpqElwPq/alCcSvBZ
	ZcVRLUlcgJdoHyyZqcLVD+yf7owXjI4s7Ms0Vy84wJBz7SWtHmetQhNiIn/VxGSEqnr76xkSwSp
	K//huj3vDBqMTNPyjCji9jpMJIzZupxK4UqQ==
X-Google-Smtp-Source: AGHT+IFKOoqgxArCn0gjdkt9n4XFKdHMqs7Bnwb0O/kKDypCoqugMI/6u6tioxeMH6WJWUAmj9EdAg==
X-Received: by 2002:a17:903:1aae:b0:273:7d52:e510 with SMTP id d9443c01a7336-290273038c3mr21978175ad.58.1759889521991;
        Tue, 07 Oct 2025 19:12:01 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125e9fsm180030465ad.36.2025.10.07.19.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 19:12:01 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
To: tj@kernel.org
Cc: sched-ext@lists.linux.dev,
	suzhidao@xiaomi.com
Subject: Re: [PATCH v2] sched/ext: Add tg->scx.idle which tracks the current state
Date: Wed,  8 Oct 2025 10:09:38 +0800
Message-ID: <20251008021031.630303-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
References: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: Add tg->scx.idle which tracks the current state  

FYI, thanks
