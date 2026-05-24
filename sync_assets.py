import fnmatch
import shutil
import sys
import time
from pathlib import Path

SOURCE = "assets"
DESTINATIONS = ["godot-project/assets", "website/assets"]
PRESERVE_PATTERNS = ["*.import"]
POLL_INTERVAL_SECONDS = 2

ROOT = Path(__file__).resolve().parent


def is_preserved(rel_path):
    name = rel_path.name
    return any(fnmatch.fnmatch(name, pat) for pat in PRESERVE_PATTERNS)


def files_under(root):
    if not root.exists():
        return {}
    out = {}
    for p in root.rglob("*"):
        if p.is_file():
            out[p.relative_to(root)] = p
    return out


def needs_copy(src, dst):
    if not dst.exists():
        return True
    s, d = src.stat(), dst.stat()
    return s.st_size != d.st_size or int(s.st_mtime) != int(d.st_mtime)


def sync_one(source_dir, dest_dir):
    added = updated = removed = 0
    src_files = files_under(source_dir)
    dst_files = files_under(dest_dir)

    for rel, src_path in src_files.items():
        dst_path = dest_dir / rel
        if not dst_path.exists():
            dst_path.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src_path, dst_path)
            added += 1
        elif needs_copy(src_path, dst_path):
            shutil.copy2(src_path, dst_path)
            updated += 1

    for rel, dst_path in dst_files.items():
        if rel in src_files:
            continue
        if is_preserved(rel):
            continue
        try:
            dst_path.unlink()
            removed += 1
        except OSError as e:
            print(f"[error] could not delete {dst_path}: {e}")

    if dest_dir.exists():
        for d in sorted(
            (p for p in dest_dir.rglob("*") if p.is_dir()),
            key=lambda p: len(p.parts),
            reverse=True,
        ):
            try:
                if not any(d.iterdir()):
                    d.rmdir()
            except OSError:
                pass

    return added, updated, removed


def sync_pass():
    source_dir = ROOT / SOURCE
    if not source_dir.exists():
        print(f"[error] source folder not found: {source_dir}")
        return False

    summaries = []
    any_change = False
    for dest_rel in DESTINATIONS:
        dest_dir = ROOT / dest_rel
        dest_dir.mkdir(parents=True, exist_ok=True)
        a, u, r = sync_one(source_dir, dest_dir)
        if a or u or r:
            any_change = True
        summaries.append(f"{dest_rel} +{a} ~{u} -{r}")

    if any_change:
        stamp = time.strftime("%H:%M:%S")
        print(f"[{stamp}] " + "  |  ".join(summaries))
    return True


def main():
    try:
        choice = input("Loop? (Enter = run once, anything else = watch): ")
    except EOFError:
        choice = ""

    try:
        sync_pass()
    except Exception as e:
        print(f"[error] {e}")

    if choice.strip() == "":
        return

    print(f"Watching {SOURCE}/ every {POLL_INTERVAL_SECONDS}s. Ctrl+C to stop.")
    while True:
        try:
            time.sleep(POLL_INTERVAL_SECONDS)
            sync_pass()
        except KeyboardInterrupt:
            print()
            return
        except Exception as e:
            print(f"[error] {e}")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print()
        sys.exit(0)
