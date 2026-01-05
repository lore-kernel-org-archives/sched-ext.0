Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D85330B2B
	for <sched-ext@lists.linux.dev>; Mon,  5 Jan 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612452; cv=none; b=gKriVGI2Xow40l69pcVSaaJmWxdGZYQZ9u708NcEh0kDeWnosVxxpnreR1uLxpPWoVz8kAPthIt71JpGUgG6+oe/+g1tQv90eZKfsrrHw67S/4oVu31TGHkV88kJAApqj6lzI2jtJYm+4VRA5xz0MawvF/QrCR0ogi+9qsxrmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612452; c=relaxed/simple;
	bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=DZtS0gclFSSEwpcN4nsvL0dOem4nPE7e4WsU+GEFO/IDwBoINMvlY/eDdak/6vusyqZbGLXwayVamC2YU5t8f56kwys6qWTyljLOW4vC+dwMC+Esxcbta+RFncxZAkLBZWURzzauBB0bsvg8MJkyXJbUzG1A9/Cr6psRi4MNYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWBNR/0D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWBNR/0D"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so151314185e9.2
        for <sched-ext@lists.linux.dev>; Mon, 05 Jan 2026 03:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612445; x=1768217245; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
        b=gWBNR/0D8ghDhxef5/UBFtRziP7ctEiy8kkxkz4UTSi8xSxzrz5ABW81eBCFYKQVr8
         H2PlP0K08C624UsyFArP1Vrij9gfWUBVocHmxVe/U/YzoqaJfqe/CEQVgoxZMtfP3fp0
         ESExaJUYB27V9MWtdOOq6wymj0NKb9UGP58K4QhouppKM7Mer1sTfJnrmlAFQAdqVItq
         slTAgcYVF79pWP/pSqKfGKBcZ9Zb2EdqFGKX9oXOydhB+rA8LjSN5mAf0wmRDCgXMnCp
         7bswHL4zt01OpsprYrG+K7JZMsZ6XMQF/rhIRHRliGC/QGQUq/PBQnj8jFNqtEN5Cfek
         JjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612445; x=1768217245;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
        b=tTLwRSMuLZTbINkC282FN/z4eCZ+f11s5CrwvSocAC4lYievFZmr7IZf0w7Yazjj+5
         XRMg2/uuKnjQI+sCxPnlbcbYnzawGkKE+FOqwQdwfw7rMN/73e5qdB/Y76a2HTEnurXP
         aacRMV/aVztMmdS6W45DwHQnoLRDzmAoHhXI4xfkSi3f5jgHmQefcsSxB8Rj+3YvRWCo
         lHDdw7Hqd9DhVXmcsLswg+gdxADucA2EKAKO2y0ACrhWJOvqvD3k6QZvfywW7mmEP7uS
         VkneOgHN0g6BV6xq8jYoPYBTOjicckPBznJH25jofLEmxVKUlDZyhUjZdzOaJZECEZdQ
         0Tzg==
X-Forwarded-Encrypted: i=1; AJvYcCXMjMnSen/A0hFGj9KSFjXh6bK2C3vBQcrUFx32XyQ/sNT3A93ne2bR/Y1bYlJcMw1jSxH5tHWm1Lc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy185Auwz7evHOkn2iYA/yd4lndQOjBJlHhFZPS8+zsNFD2UMTo
	2zfUdU6EDRwi4ch4tRvoFG1NzNL5azFO172wYFRuSedD85besqsYuVq5
X-Gm-Gg: AY/fxX6kQ91D8yjoehTly09u0MD9ykVyPLdw+Lom53tu1hNqSnv0PmvJLmOfbGLN5We
	6fdrrzpkZCE39ny1hoToMD2SX0UpRK54FjMIQ6sr+DB/ZIYpjs/B62oqbl/1QRxne6l+1YbOj2O
	A+ILpVXxhHfNPHZfr/M1CjGHPqrUBMAyxfNxKujjGOD33SIPPdWDT1dLPBSsjKkpqD80Lw86IC2
	8uW1RV34XL+qtIUPWoodfMoxT2bdGpEa1opgKW/vgzr0XDqO0N0PGE0i9+L7+1UqlrawZoOLZ2O
	7qnQ2fLXD3IK0nWnd2R8WJsNYN7X1rrLGbzqvw3TrJ1OyweE4OHxwQ00RVUIymZOIcCPC2BO9fk
	2Lu3BLtmK5oS4k8K+iXURvFqQfRMe0BSfp9sT6wyVf6gVsg0JFeXV7G2Sy+sZKpFCdiJg8HMRuw
	S2WLxj0S96Z+yVOPnW+Vqjyag=
X-Google-Smtp-Source: AGHT+IGOCrgB98HD0HT6c/uYvFFDqNubQBnKHB+ahKF1w3E0yy3UKIW2NECF/jANW1a6fJaReu1d9w==
X-Received: by 2002:a05:600c:620d:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d19549f5dmr616467065e9.10.1767612444714;
        Mon, 05 Jan 2026 03:27:24 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325d10cc48sm89865134f8f.16.2026.01.05.03.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:24 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 3/4] PM: EM: Change cpus' type from string to
 u64 array in the EM YNL spec
In-Reply-To: <20251225040104.982704-4-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:19:37 +0000
Message-ID: <m27btwi9x2.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-4-changwoo@igalia.com>
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

> Previously, the cpus attribute was a string format which was a "%*pb"
> stringification of a bitmap. That is not very consumable for a UAPI,
> so let=E2=80=99s change it to an u64 array of CPU ids.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
