Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6621A3029
	for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239623; cv=none; b=qkBmvHaYFnbOL023B/nDnx8C7J+nVrvnVD5ZaWWDN8MKlgmoBb8EKjoC68BWK1WPvQw1aiZRMyNmvJ7WHKg6ptOOGeK3jX8yQsl64iNaq/5wm9rrw5y4wYEOfWWeuFJCUE352cmitqEDGIBRqEqJT4WKxTKNx8+yaofnv6OPhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239623; c=relaxed/simple;
	bh=rUuhyPVnYQZLCvdLrrTufM3aoFS24OL2fcFXCtn5mUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YC6uzecljT4re4l7CQ+pkRrZZMz5IdBVCJiHtsG0VhfJH+UpKQj0TSrsZYGqi7Ve+sTEvlmBFGq+I2Sin8/jnc5+9Ewa5O8oFqK3htGfpK0Pcw+3HKY0tHXBb0uR4tkNpcbIFtdXXyqucRFMv2G45g9rTKG0TrxngCR4FVfZYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSWFDAfl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSWFDAfl"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82311f4070cso1668436b3a.0
        for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 03:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771239622; x=1771844422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UzPInJxSA0jpk3SuSYw5d9AZBZUbAyIBPB6qSkjbpRY=;
        b=GSWFDAflgMYz6KYWFqkgsLNNLHoJUe7M0+xdHuGxDOcdDIVfkB9kMokasBleCCzpOj
         SGvmqE4G+msBvetgN85NaULpzPnRLYNSZUk/7PhtYpQqFOMRjtcMZBPJmJ55t8sHa9nC
         fnehZp0+sswe3ZaiI2LC9+dhoyK2+Wzn1FrH4AnDuESSaAOaXt1pydDJuLPk9G1C2q2b
         YoHRt7Wmwhs7FOg318DkA6r8J/vLEmnBgF3m4d5kVfIiVCDsq617uqlALKoBwESeB4FW
         hFrCUoAmJ9fv8KNaXj/oS4Rm4A6bxTZOSr8TC01X5kvTueFhC6iL3qkr5ff2cfYjnz+g
         57xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771239622; x=1771844422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzPInJxSA0jpk3SuSYw5d9AZBZUbAyIBPB6qSkjbpRY=;
        b=mP+LL2fG7PhStaLykGw9aEpmZFPa0TjanzFESRsL7bLKFp9pkbWeaWXvqOxq1XPT2V
         hELq7r35RtqGardkDCFp8OzUH/ZUyMPURD1KHppDfjlURQ5mV6vqtwPVQa0GkDaLJRf2
         9Lq04ObMKFGs6LdC5d90+5S+3/r0KdatK72HLD7H3foTed05ySEfCbnGRhgR6qIqwCXD
         H4DwrtY+VMOoUsVfZJer04EISRmz7w4z6Y093fx/MUFKRnGiISMahJYiieg24oNJ0cKs
         VnT51G4C9echFneMAQXTq7uomx4LdrhlLfZhQAD5WJ1kIcuOQjauQbqkIN7wN9IOIbUn
         aDqA==
X-Gm-Message-State: AOJu0YwPTuF7pLrobVrQPU22WgzZEeUbFQS3yJowoyCRrd17vR1kgGDM
	r0YD/VGs9JJBNKS5AJmczWpza23wiySlorTAJ9KqK2cMfig+w0R0GQvl+1fHfw==
X-Gm-Gg: AZuq6aLIxGrGCKjqfV3uMQS8LdpxQdEs4r33yXLSsmxFDAV+Sjhta4qI4ZBQXDZPJ1G
	5CgwOZoHV99zD4AHyuUcWKPKmzXFHatkHP3Qawh+9APLNgNm5Ew6bHuuAHkwdlre8qckiU0NDZU
	fpi2k3fI0SyzMATBe0/GVx/eq2aiw5zEMUGHKkTKybhrnsSQ7ynNO3xkj5Ri4l61gTTjdg3CNJI
	WQ51CY/1lT14Zp6F6D6Jmdz4WMnlsu5VPbU37+z1lJtMiTO6gETET+o07F/8owU5lLV/okxMsBC
	/+IaRalNAol8ZWw27UOqLiqktHK/ncVp+nMy5GFC8NzujdqWjad5FcEpSSoE4smaVBUVIJkT+gu
	7wtq7BAK1fAm7SDf8jmRe/DvUo6js3AF7GO2DzXD86CjuSZEAaIJ/0AKA3HUFfSNKfmExWZIAbn
	ClUaz5OCTdVhIb99zGjlX6Tgwotlj6bGzwi660Atn6GNJCfEanSbUGWxcKH7yd2Uo=
X-Received: by 2002:a05:6a00:4108:b0:824:a146:a14 with SMTP id d2e1a72fcca58-824d5e1d5b0mr8137677b3a.18.1771239621668;
        Mon, 16 Feb 2026 03:00:21 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:87b9:1690:2f70:403c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb5596sm9978994b3a.58.2026.02.16.03.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 03:00:21 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 0/2] tools/sched_ext: Sync configuration with upstream
Date: Mon, 16 Feb 2026 19:00:12 +0800
Message-ID: <20260216110014.771335-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series synchronizes the sched-ext tool's Kconfig and README.md 
with the upstream scx repository. 

The first patch streamlines README.md by removing redundant entries. 
The second patch adds the missing Kconfig file synced from upstream.

Thanks,
-chengyang

---

Cheng-Yang Chou (2):
  tools/sched_ext: Sync README.md Kconfig with upstream scx
  tools/sched_ext: Add Kconfig to sync with upstream

 tools/sched_ext/Kconfig   | 71 +++++++++++++++++++++++++++++++++++++++
 tools/sched_ext/README.md |  9 +----
 2 files changed, 72 insertions(+), 8 deletions(-)
 create mode 100644 tools/sched_ext/Kconfig

-- 
2.48.1

